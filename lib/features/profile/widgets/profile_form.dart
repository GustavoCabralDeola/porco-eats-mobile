import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seus dados',
          style: TextStyle(
            color: AppColors.darkBrown,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Assim podemos cuidar melhor da sua entrega.',
          style: TextStyle(color: AppColors.subTitle, fontSize: 13),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Nome'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: lastNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _decoration('Sobrenome'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: emailController,
          readOnly: true,
          keyboardType: TextInputType.emailAddress,
          decoration: _decoration('E-mail'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: _decoration('Telefone'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: addressController,
          maxLines: 2,
          textCapitalization: TextCapitalization.sentences,
          decoration: _decoration('Endereço de entrega'),
        ),
      ],
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.fullWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderInputColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderInputColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.yellowAgility, width: 2),
      ),
    );
  }
}
