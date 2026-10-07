import 'package:flutter/material.dart';

import 'package:porco_eats/features/login/controllers/signup_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field.dart';

import 'package:porco_eats/shared/widgets/app_intro_text.dart';
import 'package:porco_eats/shared/widgets/app_screen_layout.dart';
import 'package:porco_eats/shared/widgets/app_switch_action.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static String route = '/signup';

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
      builder: (context, controller, child) {
        return AppScreenLayout(
          header: AppLoginHeader(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  AppIntroText(
                    title: 'Crie sua conta',
                    subtitle: 'Preencha seus dados para pedir!',
                  ),
                  SizedBox(height: 18),

                  AppTextFormField(
                    TextInputType.text,
                    hintText: 'Digite seu nome completo',
                    prefixIcon: Icons.person_outline,
                    textEditingcontroller: controller.nameController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarNome(),
                  ),

                  SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.emailAddress,
                    hintText: 'Digite seu e-mail',
                    prefixIcon: Icons.email_outlined,
                    textEditingcontroller: controller.emailController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarEmail(),
                  ),

                  SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.visiblePassword,
                    hintText: 'Digite sua senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    textEditingcontroller: controller.passwordController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarSenha(),
                  ),

                  SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.visiblePassword,
                    hintText: 'Confirme sua senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    textEditingcontroller: controller.confirmarSenhaController,
                    onChanged: (_) => controller.onFieldChanged(),
                    // validator: (value) => controller.validarConfirmarSenha(),
                  ),

                  SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 55,
                      width: double.infinity,
                      child: DropdownButton<UserRole>(
                        value: controller.selectedRole,
                        onChanged: (UserRole? newValue) {
                          if (newValue != null) {
                            controller.setSelectedRole(newValue);
                          }
                        },
                        items: UserRole.values.map((UserRole role) {
                          return DropdownMenuItem<UserRole>(
                            value: role,
                            child: Text(
                              role == UserRole.customer ? 'Cliente' : 'Gerente',
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Selecione seu tipo de conta'),
                      ),
                    ),
                  ),

                  SizedBox(height: 38),

                  AppElevatedButton(
                    prefixIcon: Icons.arrow_forward,
                    label: 'CADASTRAR',
                    type: ButtonType.filled,
                    isLoading: controller.isLoading,
                    onPressed: controller.isLoading || !controller.podeCadastrar
                        ? null
                        : () async {
                            final sucesso = await controller.cadastrarUsuario();

                            if (!context.mounted) return;

                            if (sucesso) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Cadastro realizado com sucesso!',
                                  ),
                                ),
                              );

                              Navigator.pushReplacementNamed(
                                context,
                                LoginPage.route,
                              );
                            } else if (controller.cadastroErrorMessage !=
                                null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    controller.cadastroErrorMessage!,
                                  ),
                                ),
                              );
                            }
                          },
                  ),

                  SizedBox(height: 38),

                  AppSwitchAction(
                    leadingText: 'Já possui uma conta?',
                    actionText: 'Faça login',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.route);
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),

            SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
