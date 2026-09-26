import 'package:flutter/material.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/shared/widgets/exceptions/auth_exception.dart';

class LoginController extends ChangeNotifier {
  User? user;

  bool isLoading = false;
  bool lembrarMe = false;
  bool isActiveButton = false;
  bool isActiveCheckBox = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  changeIsLoading(bool value) {
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
    if (emailController.text.trim() != 'gustavodeola@gmail.com' ||
        passwordController.text.trim() != '@Aero1224') {
      throw AuthException('E-mail ou senha inválidos');
    }
    user = User(
      name: 'Gustavo',
      email: emailController.text,
      password: passwordController.text,
    );
  }

  String? validEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu e-mail';
    }

    if (!_emailRegex.hasMatch(value.trim())) {
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
    isActiveCheckBox = !isActiveCheckBox;
    notifyListeners();
  }
}
