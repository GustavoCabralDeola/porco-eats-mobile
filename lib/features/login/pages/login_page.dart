import 'package:custom_snackbar_plus/custom_snackbar_plus.dart';
import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/login/pages/login_success_video_page.dart';
import 'package:porco_eats/features/login/pages/signup_page.dart';
import 'package:porco_eats/features/recover/pages/recover_page.dart';
import 'package:porco_eats/shared/widgets/app_checkbox.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_intro_text.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_screen_layout.dart';
import 'package:porco_eats/shared/widgets/app_switch_action.dart';
import 'package:porco_eats/shared/widgets/exceptions/auth_exception.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_elevated_button.dart';
import '../../../shared/widgets/app_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return AppScreenLayout(
          header: AppLoginHeader(),
          children: [
            SizedBox(height: 20),
            AppIntroText(
              title: 'Bem vindo(a)',
              subtitle: 'Faça login e peça o que quiser \n do seu jeito!',
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      TextInputType.emailAddress,
                      textEditingController: controller.emailController,
                      validator: (value) {
                        return controller.validEmail(value);
                      },
                      hintText: 'Digite seu email',
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 20),
                    AppTextFormField(
                      textEditingController: controller.passwordController,
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
                    AppElevatedButton(
                      prefixIcon: Icons.arrow_forward,
                      label: 'ENTRAR',
                      isLoading: controller.isLoading,
                      onPressed: () async {
                        try {
                          final loginSucess = await controller.handleLogin();

                          if (!context.mounted) return;
                          if (!loginSucess) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginSuccessVideoPage(),
                            ),
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
                    AppSwitchAction(
                      leadingText: 'Ainda não tem conta?',
                      actionText: 'Cadastre-se',
                      onPressed: () {
                        Navigator.pushNamed(context, SignupPage.route);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
