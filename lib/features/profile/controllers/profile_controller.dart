import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  ProfileController({
    required User? user,
    AppPreferences? preferences,
    SharedPreferencesAsync? profilePreferences,
  }) : user = user,
       _preferences = preferences ?? AppPreferences(),
       _profilePreferences = profilePreferences ?? SharedPreferencesAsync() {
    _setUserFields(user);
  }

  static const _detailsKeyPrefix = 'porco_eats_profile_details_';
  static const _photoKeyPrefix = 'porco_eats_profile_photo_';
  static const _passwordHistoryKeyPrefix = 'porco_eats_password_history_';

  final AppPreferences _preferences;
  final SharedPreferencesAsync _profilePreferences;

  User? user;
  bool isLoading = true;
  bool isSaving = false;
  bool isPickingPhoto = false;
  String? loadError;
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Uint8List? profileImageBytes;

  String get initials {
    final firstName = nameController.text.trim();
    final lastName = lastNameController.text.trim();
    if (firstName.isEmpty && lastName.isEmpty) return 'P';
    return '${firstName.isEmpty ? '' : firstName[0]}${lastName.isEmpty ? '' : lastName[0]}'
        .toUpperCase();
  }

  Future<void> loadProfile() async {
    isLoading = true;
    loadError = null;
    notifyListeners();

    final currentUser = user;
    try {
      if (currentUser == null) return;

      final key = _detailsKey(currentUser.email);
      final value = await _profilePreferences.getString(key);
      if (value != null) {
        try {
          final details = jsonDecode(value) as Map<String, dynamic>;
          phoneController.text = details['phone'] as String? ?? '';
          addressController.text = details['address'] as String? ?? '';
        } on FormatException {
          await _profilePreferences.remove(key);
        } on TypeError {
          await _profilePreferences.remove(key);
        }
      }

      final photo = await _profilePreferences.getString(
        _photoKey(currentUser.email),
      );
      if (photo != null) {
        try {
          profileImageBytes = base64Decode(photo);
        } on FormatException {
          await _profilePreferences.remove(_photoKey(currentUser.email));
        }
      }
    } catch (error) {
      loadError = 'Não foi possível carregar os dados do perfil: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProfilePhoto(Uint8List imageBytes) async {
    isPickingPhoto = true;
    notifyListeners();
    try {
      final currentUser = user;
      if (currentUser == null) return;

      await _profilePreferences.setString(
        _photoKey(currentUser.email),
        base64Encode(imageBytes),
      );
      profileImageBytes = imageBytes;
    } finally {
      isPickingPhoto = false;
      notifyListeners();
    }
  }

  Future<void> saveProfile() async {
    isSaving = true;
    notifyListeners();
    try {
      final currentUser = user;
      if (currentUser == null) return;

      final fullName = [
        nameController.text.trim(),
        lastNameController.text.trim(),
      ].where((part) => part.isNotEmpty).join(' ');
      final updatedUser = User(
        name: fullName,
        email: currentUser.email,
        password: currentUser.password,
        role: currentUser.role,
      );

      await _profilePreferences.setString(
        _detailsKey(currentUser.email),
        jsonEncode({
          'phone': phoneController.text.trim(),
          'address': addressController.text.trim(),
        }),
      );
      await _persistUser(updatedUser);
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> changePassword(String password) async {
    final currentUser = user;
    if (currentUser == null) return;

    if (await hasUsedPassword(password)) {
      throw StateError('Essa senha já foi utilizada anteriormente.');
    }

    final historyKey = _passwordHistoryKey(currentUser.email);
    final history =
        await _profilePreferences.getStringList(historyKey) ?? <String>[];
    final currentPasswordHash = _passwordHash(currentUser.password);
    if (!history.contains(currentPasswordHash)) {
      history.add(currentPasswordHash);
      await _profilePreferences.setStringList(historyKey, history);
    }

    await _persistUser(
      User(
        name: currentUser.name,
        email: currentUser.email,
        password: password,
        role: currentUser.role,
      ),
    );
    clearPasswordFields();
  }

  Future<bool> hasUsedPassword(String password) async {
    final currentUser = user;
    if (currentUser == null) return false;

    final candidateHash = _passwordHash(password);
    if (candidateHash == _passwordHash(currentUser.password)) return true;

    final history =
        await _profilePreferences.getStringList(
          _passwordHistoryKey(currentUser.email),
        ) ??
        <String>[];
    return history.contains(candidateHash);
  }

  Future<void> _persistUser(User updatedUser) async {
    final users = List<User>.from(await _preferences.loadRegisteredUsers());
    final index = users.indexWhere((item) => item.email == updatedUser.email);
    if (index != -1) {
      users[index] = updatedUser;
      await _preferences.saveRegisteredUsers(users);
    }

    final rememberedUser = await _preferences.loadUser();
    if (rememberedUser?.email == updatedUser.email) {
      await _preferences.saveUser(updatedUser);
    }

    user = updatedUser;
    _setUserFields(updatedUser);
    notifyListeners();
  }

  Future<void> logout() async {
    await _preferences.clearUser();
    user = null;
    notifyListeners();
  }

  void _setUserFields(User? value) {
    if (value == null) return;

    final nameParts = value.name.trim().split(RegExp(r'\s+'));
    nameController.text = nameParts.firstOrNull ?? '';
    lastNameController.text = nameParts.length > 1
        ? nameParts.skip(1).join(' ')
        : '';
    emailController.text = value.email;
  }

  String _detailsKey(String email) =>
      '$_detailsKeyPrefix${email.trim().toLowerCase()}';

  String _photoKey(String email) =>
      '$_photoKeyPrefix${email.trim().toLowerCase()}';

  String _passwordHistoryKey(String email) =>
      '$_passwordHistoryKeyPrefix${email.trim().toLowerCase()}';

  String _passwordHash(String password) =>
      sha256.convert(utf8.encode(password.trim())).toString();

  void clearPasswordFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
