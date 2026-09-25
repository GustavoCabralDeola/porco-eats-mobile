import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import '../controllers/recover_controller.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  static const route = '/recover';

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final _controller = RecoverController();
  bool _showError = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendCode() {
    FocusScope.of(context).unfocus();

    final isValid = _controller.hasValidEmail;
    setState(() => _showError = !isValid);

    if (isValid) {
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
    return Scaffold(
      backgroundColor: AppColors.fullWhite,
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
              child: Column(
                children: [
                  AppTextFormField(
                    TextInputType.emailAddress,
                    textEditingcontroller: _controller.emailController,
                    hintText: 'Digite seu email',
                    prefixIcon: Icons.mail_outline,
                    errorText: _showError ? 'Digite um e-mail válido' : null,
                    onChanged: (_) {
                      if (_showError) setState(() => _showError = false);
                    },
                    onSubmitted: (_) => _sendCode(),
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: _sendCode,
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
          ],
        ),
      ),
    );
  }
}
