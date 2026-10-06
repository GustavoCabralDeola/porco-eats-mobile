import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/profile/controllers/profile_controller.dart';
import 'package:porco_eats/features/profile/widgets/change_password_modal.dart';
import 'package:porco_eats/features/profile/widgets/logout_modal.dart';
import 'package:porco_eats/features/profile/widgets/profile_avatar.dart';
import 'package:porco_eats/features/profile/widgets/profile_form.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/headers/app_profile_header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const route = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final LoginController _loginController;
  late final ProfileController _controller;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isPickingPhoto = false;

  @override
  void initState() {
    super.initState();
    _loginController = context.read<LoginController>();
    _controller = ProfileController(user: _loginController.user);
    _controller.addListener(_handleProfileControllerChanged);
    _loadProfile();
  }

  void _handleProfileControllerChanged() {
    _loginController.user = _controller.user;
    if (mounted) setState(() {});
  }

  Future<void> _loadProfile() async {
    try {
      await _controller.loadProfile();
    } catch (_) {
      if (mounted) {
        _showMessage('Não foi possível carregar os dados do perfil.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_controller.nameController.text.trim().isEmpty &&
        _controller.lastNameController.text.trim().isEmpty) {
      _showMessage('Informe seu nome para continuar.');
      return;
    }

    setState(() => _isSaving = true);
    try {
      await _controller.saveProfile();
      if (mounted) _showMessage('Perfil atualizado com sucesso!');
    } catch (_) {
      if (mounted) _showMessage('Não foi possível salvar as alterações.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _openChangePasswordModal() {
    showDialog<void>(
      context: context,
      builder: (context) => ChangePasswordModal(
        currentPasswordController: _controller.currentPasswordController,
        newPasswordController: _controller.newPasswordController,
        confirmPasswordController: _controller.confirmPasswordController,
        currentPassword: _controller.user?.password ?? '',
        hasUsedPassword: _controller.hasUsedPassword,
        onConfirm: (password) async {
          await _controller.changePassword(password);
          if (mounted) _showMessage('Senha alterada com sucesso!');
        },
      ),
    );
  }

  Future<void> _chooseProfilePhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tirar uma foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Escolher da galeria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;

    setState(() => _isPickingPhoto = true);
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (image == null) return;

      await _controller.saveProfilePhoto(await image.readAsBytes());
    } catch (_) {
      if (mounted) {
        _showMessage('Não foi possível atualizar a foto do perfil.');
      }
    } finally {
      if (mounted) setState(() => _isPickingPhoto = false);
    }
  }

  void _openLogoutModal() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => LogoutModal(
        onConfirm: () async {
          final navigator = Navigator.of(dialogContext);
          await _controller.logout();
          _loginController.isActiveCheckBox = false;
          if (!mounted) return;
          navigator.pop();
          await navigator.pushNamedAndRemoveUntil(
            LoginPage.route,
            (route) => false,
          );
        },
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _controller.removeListener(_handleProfileControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const AppProfileHeader(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.maybePop(context),
                                icon: const Icon(Icons.arrow_back_ios),
                                color: AppColors.darkBrown,
                              ),
                              const SizedBox(width: 2),
                              const Text(
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
                                  initials: _controller.initials,
                                  imageBytes: _controller.profileImageBytes,
                                  onEditPressed: _isPickingPhoto
                                      ? () {}
                                      : _chooseProfilePhoto,
                                ),
                                if (_isPickingPhoto)
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
                            nameController: _controller.nameController,
                            lastNameController: _controller.lastNameController,
                            emailController: _controller.emailController,
                            phoneController: _controller.phoneController,
                            addressController: _controller.addressController,
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
                            isLoading: _isSaving,
                            label: 'Salvar alterações',
                            onPressed: _isSaving ? null : _saveProfile,
                          ),
                          const SizedBox(height: 18),
                          _actionTile(
                            icon: Icons.lock_outline,
                            title: 'Alterar senha',
                            onTap: _openChangePasswordModal,
                          ),
                          const SizedBox(height: 12),
                          _actionTile(
                            icon: Icons.logout,
                            title: 'Sair da conta',
                            color: AppColors.redDelivery,
                            onTap: _openLogoutModal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
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
