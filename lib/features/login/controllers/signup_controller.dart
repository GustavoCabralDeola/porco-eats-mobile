import 'package:flutter/material.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class SignupController extends ChangeNotifier {
  final AppPreferences _preferences;
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? cadastroErrorMessage;
  UserRole selectedRole = UserRole.customer;

  SignupController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences();

  bool get podeCadastrar {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmarSenhaController.text.isNotEmpty &&
        validarNome() == null &&
        validarEmail() == null &&
        validarSenha() == null &&
        validarConfirmarSenha() == null;
  }

  List<Map<String, bool>> getPasswordRequirements() {
    return [
      {'minLength': passwordController.text.length >= 6},
      {'hasUpperCase': passwordController.text.contains(RegExp(r'[A-Z]'))},
      {'hasLowerCase': passwordController.text.contains(RegExp(r'[a-z]'))},
      {'hasNumber': passwordController.text.contains(RegExp(r'[0-9]'))},
    ];
  }

  void setSelectedRole(UserRole role) {
    selectedRole = role;
    notifyListeners();
  }

  void onFieldChanged() {
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

  String? validarSenha() {
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
    cadastroErrorMessage = null;

    if (!podeCadastrar) {
      return false;
    }

    if (validarNome() != null ||
        validarEmail() != null ||
        validarSenha() != null ||
        validarConfirmarSenha() != null) {
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final registeredUsers = List<User>.from(
        await _preferences.loadRegisteredUsers(),
      );
      final emailAtual = emailController.text.trim().toLowerCase();

      final usuarioExistente = registeredUsers.any(
        (user) => user.email.trim().toLowerCase() == emailAtual,
      );

      if (usuarioExistente) {
        cadastroErrorMessage = 'Já existe um cadastro com este e-mail.';
        isLoading = false;
        notifyListeners();
        return false;
      }

      await Future.delayed(const Duration(seconds: 2));

      final novoUsuario = User(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRole,
      );

      // Adicionar o novo usuário à lista
      registeredUsers.add(novoUsuario);
      await _preferences.saveRegisteredUsers(registeredUsers);

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      cadastroErrorMessage = 'Não foi possível concluir o cadastro.';
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
