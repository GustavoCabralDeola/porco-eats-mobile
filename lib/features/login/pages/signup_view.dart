import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/signup_controller.dart'
    show SignupController;
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            AppTextField(
              controller: controller.nameController,
              onChanged: (_) => controller.onFieldChanged(),
              labelText: 'Nome completo',
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.emailController,
              onChanged: (_) => controller.onFieldChanged(),
              labelText: 'E-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.passwordController,
              onChanged: (_) => controller.onFieldChanged(),
              labelText: 'Senha',
              obscureText: true,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: controller.confirmPasswordController,
              onChanged: (_) => controller.onFieldChanged(),
              labelText: 'Confirmar senha',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AppElevatedButton(
              type: ButtonType.filled,
              backgroundColor: controller.canSignup ? Colors.red : Colors.grey,
              label: 'CADASTRAR',
              onPressed: controller.canSignup
                  ? () => controller.signupUser()
                  : null,
            ),
          ],
        );
      },
    );
  }
}
