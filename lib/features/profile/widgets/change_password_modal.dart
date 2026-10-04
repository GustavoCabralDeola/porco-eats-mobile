import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.currentPassword,
    required this.hasUsedPassword,
    required this.onConfirm,
  });

  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final String currentPassword;
  final Future<bool> Function(String password) hasUsedPassword;
  final Future<void> Function(String password) onConfirm;

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  String? _errorText;
  bool _isLoading = false;

  Future<void> _validateAndSubmit() async {
    final current = widget.currentPasswordController.text.trim();
    final next = widget.newPasswordController.text;
    final confirm = widget.confirmPasswordController.text;

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      setState(() => _errorText = 'Preencha todos os campos.');
      return;
    }
    if (current != widget.currentPassword.trim()) {
      setState(() => _errorText = 'Senha atual incorreta.');
      return;
    }
    if (next.length < 6) {
      setState(() => _errorText = 'A senha deve ter pelo menos 6 caracteres.');
      return;
    }
    if (!next.contains(RegExp(r'[A-Z]'))) {
      setState(
        () =>
            _errorText = 'A senha deve conter pelo menos uma letra maiúscula.',
      );
      return;
    }
    if (!next.contains(RegExp(r'[a-z]'))) {
      setState(
        () =>
            _errorText = 'A senha deve conter pelo menos uma letra minúscula.',
      );
      return;
    }
    if (!next.contains(RegExp(r'[0-9]'))) {
      setState(() => _errorText = 'A senha deve conter pelo menos um número.');
      return;
    }
    if (next != confirm) {
      setState(
        () => _errorText = 'A nova senha e a confirmação devem ser iguais.',
      );
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });
    try {
      if (await widget.hasUsedPassword(next)) {
        if (mounted) {
          setState(
            () => _errorText = 'Essa senha já foi utilizada anteriormente.',
          );
        }
        return;
      }
      await widget.onConfirm(next.trim());
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _errorText = 'Não foi possível alterar a senha.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alterar senha',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 20),
            _passwordField(widget.currentPasswordController, 'Senha atual'),
            const SizedBox(height: 16),
            _passwordField(widget.newPasswordController, 'Nova senha'),
            const SizedBox(height: 16),
            _passwordField(
              widget.confirmPasswordController,
              'Confirmar nova senha',
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 14),
              Text(
                _errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowAgility,
                    foregroundColor: AppColors.darkBrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
