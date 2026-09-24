import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';
import 'package:porco_eats/features/login/controllers/signup_controller.dart' show SignupController;


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final SignupController controller;

  @override
  void initState() {
    super.initState();

    controller = SignupController();
  }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return const Scaffold(
        backgroundColor: Color(0xFF202020),
        body: SafeArea(child: Center(
          child: center 
        )),
      );
    }
  }
