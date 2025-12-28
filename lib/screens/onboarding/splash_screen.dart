import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../theme/colors.dart';
import '../auth/login_screen.dart';

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
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/splash.mp4');
    
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
      
      // Set video to fill screen
      _controller.setLooping(true);
      _controller.setVolume(0); // Mute the video
      _controller.play();
      
      // Navigate to login after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          _navigateToLogin();
        }
      });
    } catch (e) {
      // If video fails to load, navigate after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _navigateToLogin();
        }
      });
    }
  }

  void _navigateToLogin() {
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
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
                    // Logo Container
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
