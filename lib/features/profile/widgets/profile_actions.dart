import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({
    super.key,
    required this.onChangePassword,
    required this.onLogout,
  });

  final VoidCallback onChangePassword;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileActionTile(
          icon: Icons.lock_outline,
          title: 'Alterar senha',
          subtitle: 'Atualize a senha da sua conta',
          onTap: onChangePassword,
        ),
        const SizedBox(height: 12),
        _ProfileActionTile(
          icon: Icons.logout,
          title: 'Sair da conta',
          subtitle: 'Encerrar sua sessão neste aparelho',
          color: AppColors.redDelivery,
          onTap: onLogout,
        ),
      ],
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color = AppColors.darkBrown,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fullWhite,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderInputColor),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.subTitle,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
