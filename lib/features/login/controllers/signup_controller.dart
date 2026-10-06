import 'package:flutter/material.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class SignupController extends ChangeNotifier {
  final AppPreferences _preferences;

  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@gmail\.com$');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? signupErrorMessage;
  UserRole? selectedRole;

  SignupController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences();

  bool get canSignup {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        selectedRole != null &&
        validateName() == null &&
        validateEmail() == null &&
        validatePassword() == null &&
        validateConfirmPassword() == null;
  }

  List<Map<String, bool>> getPasswordRequirements() {
    return [
      {'minLength': passwordController.text.length >= 5},
      {'hasUpperCase': passwordController.text.contains(RegExp(r'[A-Z]'))},
      {'hasLowerCase': passwordController.text.contains(RegExp(r'[a-z]'))},
      {'hasNumber': passwordController.text.contains(RegExp(r'[0-9]'))},
    ];
  }

  void onFieldChanged() {
    notifyListeners();
  }

  void setSelectedRole(UserRole role) {
    selectedRole = role;
    notifyListeners();
  }

  String? validateName() {
    if (nameController.text.isEmpty) {
      return 'O nome não pode estar vazio';
    }

    if (nameController.text.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }

    return null;
  }

  String? validateEmail() {
    if (emailController.text.isEmpty) {
      return 'O email não pode estar vazio';
    }

    if (!_emailRegex.hasMatch(emailController.text)) {
      return 'Formato de email inválido';
    }

    return null;
  }

  String? validatePassword() {
    if (passwordController.text.isEmpty) {
      return 'A senha não pode estar vazia';
    }

    if (passwordController.text.length < 5) {
      return 'A senha deve conter no mínimo 5 caracteres';
    }

    if (!passwordController.text.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter pelo menos uma letra maiúscula';
    }

    if (!passwordController.text.contains(RegExp(r'[a-z]'))) {
      return 'A senha deve conter pelo menos uma letra minúscula';
    }

    if (!passwordController.text.contains(RegExp(r'[0-9]'))) {
      return 'A senha deve conter pelo menos um número';
    }

    return null;
  }

  String? validateConfirmPassword() {
    if (confirmPasswordController.text.isEmpty) {
      return 'A confirmação de senha não pode estar vazia';
    }

    if (confirmPasswordController.text != passwordController.text) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<bool> signupUser() async {
    signupErrorMessage = null;

    if (!canSignup) {
      return false;
    }

    if (validateName() != null ||
        validateEmail() != null ||
        validatePassword() != null ||
        validateConfirmPassword() != null) {
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final registeredUser = await _preferences.loadRegisteredUser();
      final currentEmail = emailController.text.trim().toLowerCase();

      if (registeredUser != null &&
          registeredUser.email.trim().toLowerCase() == currentEmail) {
        signupErrorMessage = 'Já existe um cadastro com este e-mail.';
        isLoading = false;
        notifyListeners();
        return false;
      }

      await Future.delayed(const Duration(seconds: 2));

      final newUser = User(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRole ?? UserRole.customer,
      );

      await Future.delayed(const Duration(seconds: 2));

      await _preferences.saveRegisteredUser(newUser);

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      signupErrorMessage = 'Não foi possível concluir o cadastro.';
      return false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
