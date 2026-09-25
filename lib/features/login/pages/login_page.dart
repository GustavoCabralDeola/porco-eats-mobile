import 'package:custom_snackbar_plus/custom_snackbar_plus.dart';
import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_checkbox.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:porco_eats/shared/widgets/exceptions/auth_exception.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_elevated_button.dart';
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
                          validator: (value) {
                            return controller.validEmail(value);
                          },
                          hintText: 'Digite seu email',
                          prefixIcon: Icons.person_outline,
                        ),

                        SizedBox(height: 20),
                        AppTextFormField(
                          textEditingcontroller: controller.passwordController,
                          validator: (value) {
                            return controller.validPassword(value);
                          },
                          TextInputType.visiblePassword,
                          hintText: 'Digite a sua senha',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: Icons.visibility_off_outlined,
                          obscureText: true,
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            AppCheckBox(
                              value: controller.isActiveCheckBox,
                              onChanged: (value) {
                                controller.changeActiveCheckBox(value!);
                              },
                            ),
                            Text('Lembrar de mim'),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                //   Navigator.pushNamed(context, RecoverPage.route);
                              },
                              child: Text(
                                'Esqueci a senha',
                                style: TextStyle(color: AppColors.redDelivery),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 70),
                        AppElevatedButton(
                          prefixIcon: Icons.arrow_forward,
                          label: 'ENTRAR',
                          isLoading: controller.isLoading,
                          onPressed: () async {
                            try {
                              final loginSucess = await controller
                                  .handleLogin();

                              if (!loginSucess) {
                                return;
                              }

                              Navigator.popAndPushNamed(
                                context,
                                HomePage.route,
                              );
                            } on AuthException catch (e) {
                              CustomSnackbar.show(
                                context: context,
                                title: 'Erro ao fazer login',
                                label: e.message,
                                type: SnackbarType.error,
                                duration: Duration(seconds: 3),
                              );
                            }
                          },
                          type: ButtonType.filled,
                        ),

                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ainda não tem conta?'),
                            TextButton(
                              onPressed: () {
                                //Navigator.pushNamed(context, RecoverPage.route);
                              },
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
