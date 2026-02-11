import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../theme/colors.dart';
import '../../providers/auth_provider.dart';
import '../../utils/logger.dart';
import '../auth/login_screen.dart';
import '../home/main_navigation.dart';

const _tag = 'Splash';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    AppLogger.info(_tag, '_checkAuth: starting');
    final authProvider = context.read<AuthProvider>();
    await authProvider.tryAutoLogin();

    // Wait a minimum of 3 seconds for splash
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      AppLogger.info(_tag, '_checkAuth: navigating to MainNavigation');
      _navigateTo(const MainNavigation());
    } else {
      AppLogger.info(_tag, '_checkAuth: navigating to LoginScreen');
      _navigateTo(const LoginScreen());
    }
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/splash.mp4');

    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });

      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
    } catch (e) {
      // Video failed to load — auth check handles navigation
    }
  }

  void _navigateTo(Widget screen) {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.deepTeal,
      body: _isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: BahamaColors.seaGradient,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: BahamaColors.whiteSand,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: BahamaColors.deepTeal.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              BahamaColors.islandBlue,
                              BahamaColors.deepTeal,
                            ],
                          ).createShader(bounds),
                          child: const Icon(
                            Icons.sailing_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'BahamaVista',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.deepTeal,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          BahamaColors.islandBlue.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
