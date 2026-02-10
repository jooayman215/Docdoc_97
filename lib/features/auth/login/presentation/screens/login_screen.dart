import 'package:docdoc_app/core/utils/txt_style.dart';
import 'package:docdoc_app/core/widgets/app_button.dart';
import 'package:docdoc_app/core/widgets/app_txt_feild.dart';
import 'package:docdoc_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:docdoc_app/features/auth/register/presentation/screens/register_screen.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../data/login_model.dart';
import '../../logic/login_cubit.dart';
import '../../logic/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;

  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = LoginCubit();
  }

  @override
  void dispose() {
    _loginCubit.close();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    final model = LoginModel(email: email, password: pass);
    context.read<LoginCubit>().login(model);
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> _saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", userName.trim());
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Logged in successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsManager.primaryColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginCubit,
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            _showSuccessSnackBar(context);

            final userName = state.userName ?? "";

            if (rememberMe) {
              await _saveToken(state.token);

              if (userName.trim().isNotEmpty) {
                await _saveUserName(userName);
              }
            }

            if (!context.mounted) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(userName: userName),
              ),
            );
          }

          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoadingState;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      "Welcome Back",
                      style: TxtStyle.font24wight700primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                      style: TxtStyle.font14wight400Grey,
                    ),
                    const SizedBox(height: 32),

                    AppTxtFeild(
                      hintTxt: "Email",
                      textEditingController: emailController,
                    ),
                    const SizedBox(height: 16),

                    AppTxtFeild(
                      hintTxt: "Password",
                      textEditingController: passwordController,
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: ColorsManager.primaryColor,
                          onChanged: (v) {
                            setState(() => rememberMe = v ?? false);
                          },
                        ),
                        Text("Remember me", style: TxtStyle.font12wight400grey),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TxtStyle.font12wight400grey.copyWith(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                      buttonTxt: "Login",
                      function: () => _onLoginPressed(context),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: ColorsManager.neutral60,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text("Or sign in with",
                            style: TxtStyle.font12wight400grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: ColorsManager.neutral60,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SocialLogoButton(
                          assetPath: "assets/logos/google_logo.png",
                          onTap: _emptyTap,
                        ),
                        SizedBox(width: 14),
                        SocialLogoButton(
                          assetPath: "assets/logos/facebook_logo.png",
                          onTap: _emptyTap,
                        ),
                        SizedBox(width: 14),
                        SocialLogoButton(
                          assetPath: "assets/logos/apple_logo.png",
                          onTap: _emptyTap,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Center(
                      child: Text(
                        "By logging in, you agree to our Terms & Conditions\nand PrivacyPolicy.",
                        textAlign: TextAlign.center,
                        style: TxtStyle.font12wight400grey,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            " Don't have an account ",
                            style: TxtStyle.font12wight400grey,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TxtStyle.font12wight400grey.copyWith(
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ✅ عشان const Row يشتغل
void _emptyTap() {}

class SocialLogoButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const SocialLogoButton({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: ColorsManager.neutral60),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 18,
            height: 18,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
