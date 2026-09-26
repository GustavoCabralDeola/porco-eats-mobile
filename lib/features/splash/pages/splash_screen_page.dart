import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  bool _showFirstText = false;
  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _showFirstText = true);
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      setState(() => _showSecondText = true);
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: const LoginPage(),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SplashBrand(
            firstTextVisible: _showFirstText,
            secondTextVisible: _showSecondText,
          ),
        ),
      ),
    );
  }
}

class SplashBrand extends StatelessWidget {
  final bool firstTextVisible;
  final bool secondTextVisible;

  const SplashBrand({
    super.key,
    required this.firstTextVisible,
    required this.secondTextVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: AssetImage(
            'assets/images/porco_eats_images/logoporcoeats.png',
          ),
          width: 220,
          height: 220,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 18),
        SplashText(
          text: 'Seu Pedido',
          visible: firstTextVisible,
          color: AppColors.darkBrown,
        ),
        const SizedBox(height: 6),
        SplashText(
          text: 'Nossa Missão',
          visible: secondTextVisible,
          color: AppColors.redDelivery,
        ),
      ],
    );
  }
}

class SplashText extends StatelessWidget {
  final String text;
  final bool visible;
  final Color color;

  const SplashText({
    super.key,
    required this.text,
    required this.visible,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
