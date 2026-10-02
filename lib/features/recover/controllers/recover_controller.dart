import 'package:flutter/material.dart';

class RecoverController extends ChangeNotifier {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RecoverController() {
    emailController.addListener(notifyListeners);
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Digite seu e-mail';
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Digite um e-mail válido';
    }
    //aaa
    return null;
  }

  @override
  void dispose() {
    emailController.removeListener(notifyListeners);
    emailController.dispose();
    super.dispose();
  }
}
