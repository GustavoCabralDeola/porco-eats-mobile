import 'package:flutter/material.dart';

import 'package:porco_eats/features/login/controllers/signup_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

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
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              
                const AppLoginHeader(),

                const SizedBox(height: 20),

            
                Text(
                  'Crie sua conta',
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

              
                Text(
                  'Preencha seus dados para pedir!',
                  style: AppTextStyle.subTitle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 18),

                
                AppTextFormField(
                  TextInputType.text,
                  hintText: 'Digite seu nome completo',
                  prefixIcon: Icons.person_outline,
                  textEditingcontroller: controller.nameController,
                  validator: (value) {
                    return controller.validarNome();
                  },
                ),
                

                const SizedBox(height: 15),

             
                AppTextFormField(
                  TextInputType.emailAddress,
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icons.email_outlined,
                  textEditingcontroller: controller.emailController,
                  validator: (value) {
                    return controller.validarEmail();
                  },
                ),
                
                const SizedBox(height: 15),

                AppTextFormField(
                  TextInputType.text,
                  hintText: 'Digite sua senha',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: controller.isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  textEditingcontroller: controller.passwordController,
                  validator: (value) {
                    return controller.valoidarSenha();
                  },
                ),
        
                const SizedBox(height: 15),

                
                AppTextFormField(
                  TextInputType.text,
                  hintText: 'Confirme sua senha',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: controller.isConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  textEditingcontroller: controller.confirmarSenhaController,
                  validator: (value) {
                    return controller.validarConfirmarSenha();
                  },
                ),

                
                const SizedBox(height: 38),


                 AppElevatedButton(
                  prefixIcon: Icons.arrow_forward,
                  label: 'CADASTRAR', 
                  type:  ButtonType.filled,
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
                          }
                        },
                  ), 

                
                const SizedBox(height: 38),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já possui uma conta?', textAlign: TextAlign.center),

                TextButton(

                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.route);
                  },

                  child: Text('Faça login', style: TextStyle(
                    color: AppColors.redDelivery,
                  )),
                ),
                  ],
                ),

                const SizedBox(height: 70),
              ],
            ),
          );
        },
      ),
    );
  }
}