import 'package:docdoc_app/core/utils/txt_style.dart';
import 'package:docdoc_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:docdoc_app/features/home/presentation/screens/home_screen.dart';
import 'package:docdoc_app/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seen_onboarding') ?? false;
    final token = prefs.getString("token");
    final savedName = prefs.getString("username") ?? "";
    if (!mounted) return;

    if (!seen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
      return;
    }

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
          MaterialPageRoute(builder: (_) => HomeScreen(userName: savedName)),

      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: height * 0.22,
              left: -width * 0.12,
              child: Opacity(
                opacity: 1.0,
                child: Image.asset(
                  "assets/images/splash.png",
                  width: width * 1.18,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: width * 0.12,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: width * 0.03),
                  const Text(
                    "Docdoc",
                    style: TxtStyle.font18wight700textDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
