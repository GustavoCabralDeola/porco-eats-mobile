import 'package:flutter/material.dart';

class RecoverController {
  final emailController = TextEditingController();

  bool get hasValidEmail {
    final email = emailController.text.trim();
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void dispose() {
    emailController.dispose();
  }
}
