import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/theme.dart';
import 'screens/onboarding/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const BahamaVistaApp());
}

class BahamaVistaApp extends StatelessWidget {
  const BahamaVistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BahamaVista',
      debugShowCheckedModeBanner: false,
      theme: BahamaTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
