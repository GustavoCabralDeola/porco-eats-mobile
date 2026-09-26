import 'package:flutter/material.dart';

class SignupController extends ChangeNotifier {
  final RegExp _emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool get podeCadastrar {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmarSenhaController.text.isNotEmpty &&
        validarNome() == null &&
        validarEmail() == null &&
        valoidarSenha() == null &&
        validarConfirmarSenha() == null;
  }

  List<Map<String, bool>> getPasswordRequirements() {
    return [
      {
        'minLength': passwordController.text.length >= 6,
      },
      {
        'hasUpperCase':
            passwordController.text.contains(RegExp(r'[A-Z]')),
      },
      {
        'hasLowerCase':
            passwordController.text.contains(RegExp(r'[a-z]')),
      },
      {
        'hasNumber':
            passwordController.text.contains(RegExp(r'[0-9]')),
      },
    ];
  }

  void onfieldChanged() {
    notifyListeners();
  }

  String? validarNome() {
    if (nameController.text.isEmpty) {
      return 'O nome não pode estar vazio';
    }

    if (nameController.text.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }

    return null;
  }

  String? validarEmail() {
    if (emailController.text.isEmpty) {
      return 'O email não pode estar vazio';
    }

    if (!_emailRegex.hasMatch(emailController.text)) {
      return 'Formato de email inválido';
    }

    return null;
  }

  String? valoidarSenha() {
    if (passwordController.text.isEmpty) {
      return 'A senha não pode estar vazia';
    }

    if (passwordController.text.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
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

  String? validarConfirmarSenha() {
    if (confirmarSenhaController.text.isEmpty) {
      return 'A confirmação de senha não pode estar vazia';
    }

    if (confirmarSenhaController.text != passwordController.text) {
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

  Future<bool> cadastrarUsuario() async {
    if (!podeCadastrar) {
      return false;
    }

    if (validarNome() != null ||
        validarEmail() != null ||
        valoidarSenha() != null ||
        validarConfirmarSenha() != null) {
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(
        const Duration(seconds: 2),
      );

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }
}