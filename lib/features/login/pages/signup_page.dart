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

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static String route = '/signup';

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
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return AppScreenLayout(
          header: const AppLoginHeader(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const AppIntroText(
                    title: 'Crie sua conta',
                    subtitle: 'Preencha seus dados para pedir!',
                  ),
                  const SizedBox(height: 18),

                  AppTextFormField(
                    TextInputType.text,
                    hintText: 'Digite seu nome completo',
                    prefixIcon: Icons.person_outline,
                    textEditingController: controller.nameController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarNome(),
                  ),

                  const SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.emailAddress,
                    hintText: 'Digite seu e-mail',
                    prefixIcon: Icons.email_outlined,
                    textEditingController: controller.emailController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarEmail(),
                  ),

                  const SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.visiblePassword,
                    hintText: 'Digite sua senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    textEditingController: controller.passwordController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarSenha(),
                  ),

                  const SizedBox(height: 15),

                  AppTextFormField(
                    TextInputType.visiblePassword,
                    hintText: 'Confirme sua senha',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    textEditingController: controller.confirmarSenhaController,
                    onChanged: (_) => controller.onFieldChanged(),
                    validator: (value) => controller.validarConfirmarSenha(),
                  ),

                  const SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 55,
                      width: 180,
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
                        underline: const SizedBox(),
                        hint: const Text('Selecione seu tipo de conta'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 38),

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

                  const SizedBox(height: 38),

                  AppSwitchAction(
                    leadingText: 'Já possui uma conta?',
                    actionText: 'Faça login',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.route);
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
