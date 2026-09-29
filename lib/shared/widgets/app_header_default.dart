import 'package:flutter/material.dart';

class AppHeaderDefault extends StatelessWidget {
  const AppHeaderDefault({super.key, this.children});

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/porco_eats_images/fundomarromappbar.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
