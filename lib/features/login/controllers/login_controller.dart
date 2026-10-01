import 'package:flutter/material.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';
import 'package:porco_eats/shared/widgets/exceptions/auth_exception.dart';

class LoginController extends ChangeNotifier {
  final AppPreferences _preferences;

  LoginController({AppPreferences? preferences, User? rememberedUser})
    : _preferences = preferences ?? AppPreferences() {
    user = rememberedUser;
    if (rememberedUser != null) {
      emailController.text = rememberedUser.email;
      isActiveCheckBox = true;
    }
  }

  User? user;

  bool isLoading = false;
  bool lembrarMe = false;
  bool isActiveButton = false;
  bool isActiveCheckBox = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    changeIsLoading(true);

    try {
      await login();

      emailController.clear();
      passwordController.clear();

      return true;
    } finally {
      changeIsLoading(false);
    }
  }

  Future<void> login() async {
    await Future.delayed(Duration(seconds: 2));
    final registeredUser = await _preferences.loadRegisteredUser();

    if (registeredUser == null) {
      throw AuthException(
        'Nenhum cadastro encontrado. Crie uma conta primeiro.',
      );
    }

    if (emailController.text.trim() != registeredUser.email ||
        passwordController.text.trim() != registeredUser.password) {
      throw AuthException('E-mail ou senha inválidos');
    }

    user = registeredUser;

    if (isActiveCheckBox) {
      await _preferences.saveUser(user!);
    } else {
      await _preferences.clearUser();
    }
  }

  String? validEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu e-mail';
    }

    if (_emailRegex.hasMatch(value.trim())) {
      return null;
    }
    return 'E-mail inválido';
  }

  String? validPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite sua senha';
    }

    if (value.trim().length < 6) {
      return 'A senha deve conter mais de 5 caracteres';
    }

    return null;
  }

  void validFieldsForButton() {
    isActiveButton =
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }

  void changeActiveCheckBox(bool value) {
    isActiveCheckBox = value;
    notifyListeners();
  }
}
