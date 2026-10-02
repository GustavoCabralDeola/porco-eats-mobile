import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:provider/provider.dart';
import '../controllers/recover_controller.dart';

class RecoverPage extends StatelessWidget {
  const RecoverPage({super.key});

  static const route = '/recover';

  void _sendCode(BuildContext context, RecoverController controller) {
    FocusScope.of(context).unfocus();

    if (controller.formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Se o e-mail estiver cadastrado, enviaremos o código de redefinição.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecoverController(),
      child: Consumer<RecoverController>(
        builder: (context, controller, child) => Scaffold(
          backgroundColor: Color(0xFFF7F6F2),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLoginHeader(),
                const SizedBox(height: 20),
                Text(
                  'Esqueceu a senha?',
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Insira seu e-mail cadastrado e enviaremos\num código de redefinição.',
                  style: AppTextStyle.subTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        AppTextFormField(
                          TextInputType.emailAddress,
                          textEditingcontroller: controller.emailController,
                          hintText: 'Digite seu email',
                          prefixIcon: Icons.mail_outline,
                          validator: controller.validateEmail,

                          onSubmitted: (_) => _sendCode(context, controller),
                        ),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () => _sendCode(context, controller),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            foregroundColor: AppColors.fullWhite,
                            backgroundColor: AppColors.redDelivery,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_right),
                              SizedBox(width: 5),
                              Text('ENVIAR CÓDIGO'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Lembrou sua senha?'),
                            TextButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(color: AppColors.redDelivery),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
