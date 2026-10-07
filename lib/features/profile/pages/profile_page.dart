import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/profile/controllers/profile_controller.dart';
import 'package:porco_eats/features/profile/widgets/change_password_modal.dart';
import 'package:porco_eats/features/profile/widgets/logout_modal.dart';
import 'package:porco_eats/features/profile/widgets/profile_avatar.dart';
import 'package:porco_eats/features/profile/widgets/profile_form.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/headers/app_profile_header.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final loginController = context.read<LoginController>();
        final profileController = ProfileController(user: loginController.user);
        profileController.addListener(() {
          loginController.user = profileController.user;
        });
        unawaited(profileController.loadProfile());
        return profileController;
      },
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return Scaffold(
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer(selectedIndex: 3)
              : const AppHomeNavigationBarManager(selectedIndex: 3);
        },
      ),
      backgroundColor: AppColors.brownWhite,
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.loadError != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.loadError!, textAlign: TextAlign.center),
                  TextButton(
                    onPressed: controller.loadProfile,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  AppProfileHeader(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 18, 18, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 2),
                            Text(
                              'Meu perfil',
                              style: TextStyle(
                                color: AppColors.darkBrown,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),

                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ProfileAvatar(
                                initials: controller.initials,
                                imageBytes: controller.profileImageBytes,
                                onEditPressed: controller.isPickingPhoto
                                    ? () {}
                                    : () => _chooseProfilePhoto(
                                        context,
                                        controller,
                                      ),
                              ),
                              if (controller.isPickingPhoto)
                                const SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        ProfileForm(
                          nameController: controller.nameController,
                          lastNameController: controller.lastNameController,
                          emailController: controller.emailController,
                          phoneController: controller.phoneController,
                          addressController: controller.addressController,
                        ),
                        const SizedBox(height: 24),
                        AppElevatedButton(
                          height: 54,
                          type: ButtonType.filled,
                          backgroundColor: AppColors.yellowAgility,
                          borderRadius: BorderRadius.circular(12),
                          labelStyle: const TextStyle(
                            color: AppColors.darkBrown,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          isLoading: controller.isSaving,
                          label: 'Salvar alterações',
                          onPressed: controller.isSaving
                              ? null
                              : () => _saveProfile(context, controller),
                        ),
                        const SizedBox(height: 18),
                        _actionTile(
                          icon: Icons.lock_outline,
                          title: 'Alterar senha',
                          onTap: () =>
                              _openChangePasswordModal(context, controller),
                        ),
                        const SizedBox(height: 12),
                        _actionTile(
                          icon: Icons.logout,
                          title: 'Sair da conta',
                          color: AppColors.redDelivery,
                          onTap: () => _openLogoutModal(context, controller),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _saveProfile(
    BuildContext context,
    ProfileController controller,
  ) async {
    if (controller.nameController.text.trim().isEmpty &&
        controller.lastNameController.text.trim().isEmpty) {
      _showMessage(context, 'Informe seu nome para continuar.');
      return;
    }

    try {
      await controller.saveProfile();
      if (context.mounted) {
        _showMessage(context, 'Perfil atualizado com sucesso!');
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(context, 'Não foi possível salvar as alterações.');
      }
    }
  }

  void _openChangePasswordModal(
    BuildContext context,
    ProfileController controller,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => ChangePasswordModal(
        currentPasswordController: controller.currentPasswordController,
        newPasswordController: controller.newPasswordController,
        confirmPasswordController: controller.confirmPasswordController,
        currentPassword: controller.user?.password ?? '',
        hasUsedPassword: controller.hasUsedPassword,
        onConfirm: (password) async {
          await controller.changePassword(password);
          if (context.mounted) {
            _showMessage(context, 'Senha alterada com sucesso!');
          }
        },
      ),
    );
  }

  Future<void> _chooseProfilePhoto(
    BuildContext context,
    ProfileController controller,
  ) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Tirar uma foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text('Escolher da galeria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (source == null || !context.mounted) return;

    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (image == null) return;

      await controller.saveProfilePhoto(await image.readAsBytes());
    } catch (_) {
      if (context.mounted) {
        _showMessage(context, 'Não foi possível atualizar a foto do perfil.');
      }
    }
  }

  void _openLogoutModal(BuildContext context, ProfileController controller) {
    final loginController = context.read<LoginController>();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => LogoutModal(
        onConfirm: () async {
          final navigator = Navigator.of(dialogContext);
          await controller.logout();
          loginController.isActiveCheckBox = false;
          if (!dialogContext.mounted) return;
          navigator.pop();
          await navigator.pushNamedAndRemoveUntil(
            LoginPage.route,
            (route) => false,
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = AppColors.darkBrown,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7E2DA)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        trailing: Icon(Icons.chevron_right, color: color),
        onTap: onTap,
      ),
    );
  }
}
