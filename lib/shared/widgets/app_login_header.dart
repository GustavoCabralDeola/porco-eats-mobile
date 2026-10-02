import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_logo.dart';

class AppLoginHeader extends StatelessWidget {
  const AppLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/porco_eats_images/Rectangle 3.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 0,
            left: -10,
            child: Image.asset('assets/images/porco_eats_images/Vector 1.png'),
          ),

          Positioned(
            height: 149,
            top: 62,
            right: -123,
            child: Image.asset(
              'assets/images/porco_eats_images/Vector 4.png',
              width: 350,
              height: 107.21,
            ),
          ),

          Positioned(
            top: 35,
            right: 0,
            child: Image.asset('assets/images/porco_eats_images/Vector 5.png'),
          ),

          Positioned(
            top: 64,
            right: 0,
            child: Image.asset('assets/images/porco_eats_images/Vector 6.png'),
          ),

          Positioned(
            top: 147,
            left: 0,
            child: Image.asset('assets/images/porco_eats_images/Vector 3.png'),
          ),

          Positioned(
            top: 127,
            left: 0,
            child: Image.asset('assets/images/porco_eats_images/Vector 2.png'),
          ),

          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: AppLogo(height: 200, heroTag: 'porco-eats-logo'),
            ),
          ),
        ],
      ),
    );
  }
}
