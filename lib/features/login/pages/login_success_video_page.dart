import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:video_player/video_player.dart';

class LoginSuccessVideoPage extends StatefulWidget {
  const LoginSuccessVideoPage({super.key});

  @override
  State<LoginSuccessVideoPage> createState() => _LoginSuccessVideoPageState();
}

class _LoginSuccessVideoPageState extends State<LoginSuccessVideoPage>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoController;
  late final AnimationController _loadingDotsController;

  @override
  void initState() {
    super.initState();
    _loadingDotsController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat();
    _videoController = VideoPlayerController.asset(
      'assets/videos/login_success.mp4',
    );
    _playVideoAndOpenHome();
  }

  Future<void> _playVideoAndOpenHome() async {
    try {
      await _videoController.initialize();
      if (!mounted) return;
      setState(() {});
      await _videoController.play();
    } catch (_) {}
    await Future<void>.delayed(const Duration(seconds: 8));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(showInitialSkeleton: true),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _loadingDotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_videoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _loadingDotsController,
              builder: (context, child) {
                final dotCount = (_loadingDotsController.value * 3).floor() + 1;
                return Text(
                  'Carregando${'.' * dotCount}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
