import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

import '../../../shared/widgets/app_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Column(
                children: [
                  AppTextFormField(
                    TextInputType.emailAddress,
                    hintText: 'Digite seu email',
                    prefixIcon: Icons.person_outline,
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Digite a sua senha',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 24.0, right: 12.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        color: AppColors.darkBrown,
                      ),
                      filled: true,
                      fillColor: AppColors.fullWhite,
                      contentPadding: EdgeInsets.symmetric(vertical: 18),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: AppColors.borderInputColor,
                          width: 1.5,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: Colors.black87,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
