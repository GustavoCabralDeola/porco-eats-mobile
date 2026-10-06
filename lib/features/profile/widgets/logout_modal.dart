import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';

class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sair da conta'),
      content: const Text('Deseja realmente sair da sua conta?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        SizedBox(
          width: 90,
          child: AppElevatedButton(
            type: ButtonType.filled,
            label: 'Sair',
            onPressed: onConfirm,
          ),
        ),
      ],
    );
  }
}
