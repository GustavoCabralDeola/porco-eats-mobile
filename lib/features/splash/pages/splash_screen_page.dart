import 'package:flutter/material.dart';
import 'package:porco_eats/features/Dashboard/dashboard_order_page.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  final bool hasRememberedUser;

  const SplashScreen({super.key, required this.hasRememberedUser});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final AnimationController _logoController;
  late final Animation<double> _logoAnimation;

  bool _showFirstText = false;
  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOutCubic,
    );
    _logoController.addStatusListener(_handleLogoAnimationStatus);

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
      _logoController.forward();
    });
  }

  void _handleLogoAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) return;

    final destination = widget.hasRememberedUser
        ? const HomePage()
        : const LoginPage();

    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return destination;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SplashBrand(
          firstTextVisible: _showFirstText,
          secondTextVisible: _showSecondText,
          logoProgress: _logoAnimation,
        ),
      ),
    );
  }
}

class SplashBrand extends StatelessWidget {
  final bool firstTextVisible;
  final bool secondTextVisible;
  final Animation<double> logoProgress;

  const SplashBrand({
    super.key,
    required this.firstTextVisible,
    required this.secondTextVisible,
    required this.logoProgress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final initialLogoTop = (constraints.maxHeight - 306) / 2;

        return AnimatedBuilder(
          animation: logoProgress,
          builder: (context, child) {
            final progress = logoProgress.value;
            final logoSize = 180 + (30 * progress);
            final logoTop = initialLogoTop + ((35 - initialLogoTop) * progress);

            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 220, height: 220),
                      const SizedBox(height: 18),
                      SplashText(
                        text: 'Seu Pedido',
                        visible: firstTextVisible && progress == 0,
                        color: AppColors.darkBrown,
                      ),
                      const SizedBox(height: 6),
                      SplashText(
                        text: 'Nossa Missão',
                        visible: secondTextVisible && progress == 0,
                        color: AppColors.redDelivery,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth - logoSize) / 2,
                  top: logoTop,
                  width: logoSize,
                  height: logoSize,
                  child: child!,
                ),
              ],
            );
          },
          child: const AppLogo(
            width: 220,
            height: 220,
            fit: BoxFit.contain,
            heroTag: 'porco-eats-logo',
          ),
        );
      },
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
