import 'package:flutter/material.dart';
import 'dart:typed_data';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.initials,
    required this.onEditPressed,
    this.imageBytes,
  });

  final String initials;
  final Uint8List? imageBytes;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF4A2B1A), Color(0xFF2D170B)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: imageBytes == null
                ? Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                : Image.memory(
                    imageBytes!,
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Tooltip(
            message: 'Alterar foto do perfil',
            child: Material(
              color: const Color(0xFFFFB719),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onEditPressed,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Color(0xFF2D170B),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
