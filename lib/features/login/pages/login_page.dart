import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_checkbox.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:porco_eats/shared/widgets/exceptions/auth_exception.dart';
import 'package:provider/provider.dart';
import 'package:porco_eats/features/recover/pages/recover_page.dart';

import '../../../shared/widgets/app_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<LoginController>(
          builder: (context, controller, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppLoginHeader(),
                SizedBox(height: 20),
                Text(
                  'Bem vindo(a)',
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Faça login e peça o que quiser \n do seu jeito!',
                  style: AppTextStyle.subTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        AppTextFormField(
                          TextInputType.emailAddress,
                          textEditingcontroller: controller.emailController,
                          validator: controller.validEmail,
                          hintText: 'Digite seu email',
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 20),
                        AppTextFormField(
                          TextInputType.visiblePassword,
                          textEditingcontroller: controller.senhaController,
                          validator: controller.validPassword,
                          hintText: 'Digite a sua senha',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            AppCheckBox(
                              value: controller.isActiveCheckBox,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.changeActiveCheckBox(value);
                                }
                              },
                            ),
                            Text('Lembrar de mim'),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RecoverPage.route);
                              },
                              child: Text(
                                'Esqueci a senha',
                                style: TextStyle(color: AppColors.redDelivery),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () async {
                                  try {
                                    final loggedIn =
                                        await controller.handleLogin();
                                    if (loggedIn && context.mounted) {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          const SnackBar(
                                            content: Text('Login realizado.'),
                                          ),
                                        );
                                    }
                                  } on AuthException catch (error) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(error.message),
                                          ),
                                        );
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(48),
                            foregroundColor: AppColors.fullWhite,
                            backgroundColor: AppColors.redDelivery,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_right),
                              SizedBox(width: 5),
                              Text(controller.isLoading ? 'AGUARDE' : 'ENTRAR'),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ainda não tem conta?'),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                'Cadastre-se',
                                style: TextStyle(color: AppColors.redDelivery),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
