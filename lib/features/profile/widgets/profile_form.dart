import 'package:flutter/material.dart';

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
      children: [
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
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD9D7D3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD9D7D3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFFB719), width: 2),
      ),
    );
  }
}
