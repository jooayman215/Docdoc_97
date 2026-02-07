import 'package:docdoc_app/features/auth/register/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/widgets/app_button.dart';
import '../../core/utils/txt_style.dart';
import '../../core/utils/colors_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Stack(
          children: [
            // watermark background (Group)
            Positioned(
              top: height * 0.15,
              left: -width * 0.12,
              child: Opacity(
                opacity: 1.0,
                child: Image.asset(
                  "assets/images/onboarding_picture.png",
                  width: width * 1.18,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Column(
              children: [
                SizedBox(height: height * 0.03),

                // top brand (logo + docdoc)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: width * 0.08,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: width * 0.02),
                    const Text(
                      "Docdoc",
                      style: TxtStyle.font18wight700textDark,
                    ),
                  ],
                ),

                SizedBox(height: height * 0.05),

                // doctor image + linear effect
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/doctor.png",
                          width: width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          "assets/images/Linear Effect.png",
                          width: width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.015),

                // Title
                const Text(
                  "Best Doctor\nAppointment App",
                  textAlign: TextAlign.center,
                  style: TxtStyle.font24wight700primaryColor,
                ),

                SizedBox(height: height * 0.012),

                // Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.12),
                  child: const Text(
                    "Manage and schedule all of your medical appointments easily\nwith Docdoc to get a new experience.",
                    textAlign: TextAlign.center,
                    style: TxtStyle.font12wight400grey,
                  ),
                ),

                SizedBox(height: height * 0.03),

                // Button
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.06,
                    right: width * 0.06,
                    bottom: height * 0.02,
                  ),
                  child: AppButton(
                    buttonTxt: "Get Started",
                    function: () => _finish(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
