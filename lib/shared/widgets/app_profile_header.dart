import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

import 'app_header_default.dart';

class AppProfileHeader extends StatelessWidget {
  const AppProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: double.infinity,
      child: AppHeaderDefault(
        children: [
          Positioned(
            left: 30,
            top: 60,
            child: Image(
              image: AssetImage(
                'assets/images/porco_eats_images/logoporcoeats.png',
              ),
              height: 60,
              width: 60,
            ),
          ),
          Positioned(
            left: 100,
            top: 65,
            child: Text(
              'PORCO',
              style: GoogleFonts.anton(
                fontSize: 15,
                color: AppColors.fullWhite,
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: 65,
            child: Text(
              'EATS',
              style: GoogleFonts.anton(
                fontSize: 15,
                color: AppColors.yellowAgility,
              ),
            ),
          ),
          Positioned(
            left: 98,
            top: 90,
            child: Text(
              'Seu pedido,',
              style: GoogleFonts.anton(
                fontSize: 12,
                color: AppColors.fullWhite,
              ),
            ),
          ),
          Positioned(
            left: 160,
            top: 91,
            child: Text(
              'nossa missão!',
              style: GoogleFonts.anton(
                fontSize: 12,
                color: AppColors.redDelivery,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 48,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
