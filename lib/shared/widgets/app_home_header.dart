import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

import 'app_header_default.dart';

class AppHomeHeader extends StatelessWidget {
  const AppHomeHeader({super.key});

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
              style: TextStyle(fontSize: 15, color: AppColors.fullWhite),
            ),
          ),

          Positioned(
            left: 140,
            top: 65,
            child: Text(
              'EATS',
              style: TextStyle(fontSize: 15, color: AppColors.yellowAgility),
            ),
          ),

          Positioned(
            left: 98,
            top: 90,
            child: Text(
              'Seu pedido,',
              style: TextStyle(fontSize: 12, color: AppColors.fullWhite),
            ),
          ),

          Positioned(
            left: 160,
            top: 91,
            child: Text(
              'nossa missão!',
              style: TextStyle(fontSize: 12, color: AppColors.redDelivery),
            ),
          ),

          Positioned(
            left: 250,
            top: 68,
            child: Icon(
              Icons.location_on,
              size: 20,
              color: AppColors.yellowAgility,
            ),
          ),

          Positioned(
            left: 275,
            top: 66,
            child: Row(
              children: [
                Text(
                  'Entregar em',
                  style: TextStyle(fontSize: 10, color: AppColors.fullWhite),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.yellowAgility,
                ),
              ],
            ),
          ),

          Positioned(
            left: 275,
            top: 86,
            child: Text(
              'Blumenau, SC',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.fullWhite,
                fontWeight: FontWeight.bold,
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
