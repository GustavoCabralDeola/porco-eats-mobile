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
  TextEditingController senhaController = TextEditingController();
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isSenhaLengthValid => senhaController.text.trim().length >= 6;
  bool get isEmailValid => _emailRegex.hasMatch(emailController.text.trim());

  changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) {
      throw ErrorDescription('validacao_incorreta');
    }

    changeIsLoading(true);

    try {
      await login();
      emailController.clear();
      senhaController.clear();
    } finally {
      changeIsLoading(false);
    }

    return;
  }

  Future<void> login() async {
    //Simula o delay de uma chamada de API
    await Future.delayed(Duration(seconds: 2));
    if (emailController.text.trim() != 'gustavodeola@gmail.com' ||
        senhaController.text.trim() != '@Aero1224') {
      throw AuthException('E-mail ou senha inválidos');
    }
    user = User(
      name: 'Gustavo',
      email: emailController.text,
      password: senhaController.text,
    );
  }

  String? validEmail(String? value) {
    if (isEmailValid) {
      return null;
    }
    return 'E-mail inválido';
  }

  String? validPassword(String? value) {
    if (isSenhaLengthValid) {
      return null;
    }

    return 'A senha deve conter mais de 5 caracteres';
  }

  void validFieldsForButton() {
    isActiveButton =
        emailController.text.trim().isNotEmpty &&
        senhaController.text.trim().isNotEmpty;
  }

  void changeActiveCheckBox(bool value) {
    isActiveCheckBox = !isActiveCheckBox;
    notifyListeners();
  }
}
