import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/signup_controller.dart'
    show SignupController;
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            TextField(
              controller: controller.nameController,
              onChanged: (_) => controller.onFieldChanged(),
            ),

            TextField(
              controller: controller.emailController,
              onChanged: (_) => controller.onFieldChanged(),
            ),

            TextField(
              controller: controller.passwordController,
              onChanged: (_) => controller.onFieldChanged(),
            ),

            TextField(
              controller: controller.confirmarSenhaController,
              onChanged: (_) => controller.onFieldChanged(),
            ),

            ElevatedButton(
              onPressed: controller.podeCadastrar
                  ? () => controller.cadastrarUsuario()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.podeCadastrar
                    ? Colors.red
                    : Colors.grey,
              ),
              child: const Text('CADASTRAR'),
            ),
          ],
        );
      },
    );
  }
}
