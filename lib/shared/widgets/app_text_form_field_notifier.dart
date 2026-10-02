import 'package:flutter/material.dart';

class AppTextFormFieldNotifier extends ChangeNotifier {
  AppTextFormFieldNotifier(bool obscureText) : _isObscure = obscureText;

  bool _isObscure;

  bool get isObscure => _isObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
