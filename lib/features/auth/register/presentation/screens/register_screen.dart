import 'package:docdoc_app/core/utils/colors_manager.dart';
import 'package:docdoc_app/core/utils/txt_style.dart';
import 'package:docdoc_app/core/widgets/app_button.dart';
import 'package:docdoc_app/core/widgets/app_txt_feild.dart';
import 'package:docdoc_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:docdoc_app/features/auth/register/data/user_model.dart';
import 'package:docdoc_app/features/auth/register/logic/cubit.dart';
import 'package:docdoc_app/features/auth/register/logic/state.dart';
import 'package:docdoc_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final phoneNumberController = TextEditingController();

  late final RegisterCubit _registerCubit;

  @override
  void initState() {
    super.initState();
    _registerCubit = RegisterCubit();
  }

  @override
  void dispose() {
    _registerCubit.close();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    genderController.dispose();
    passwordConfirmationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerCubit,
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) async {
          if (state is RegisterSuccessState) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("token", state.token);

            if (state.userName.trim().isNotEmpty) {
              await prefs.setString("username", state.userName.trim());
            }

            if (!context.mounted) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(userName: state.userName),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "Account created successfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoadingState;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Account", style: TxtStyle.font24wight700Blue),
                    Text(
                      "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                      style: TxtStyle.font14wight400Grey,
                    ),

                    AppTxtFeild(
                      hintTxt: "Email",
                      textEditingController: emailController,
                    ),
                    AppTxtFeild(
                      hintTxt: "name",
                      textEditingController: nameController,
                    ),
                    AppTxtFeild(
                      hintTxt: "Phone Number",
                      textEditingController: phoneNumberController,
                    ),
                    AppTxtFeild(
                      hintTxt: "Gender",
                      textEditingController: genderController,
                    ),
                    AppTxtFeild(
                      hintTxt: "Password",
                      textEditingController: passwordController,
                    ),
                    AppTxtFeild(
                      hintTxt: "Password Confirmation",
                      textEditingController: passwordConfirmationController,
                    ),

                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                      buttonTxt: "Create Account",
                      function: () {
                        context.read<RegisterCubit>().register(
                          UserModel(
                            email: emailController.text.trim(),
                            name: nameController.text.trim(),
                            gender: genderController.text.trim(),
                            phoneNumber:
                            phoneNumberController.text.trim(),
                            password: passwordController.text.trim(),
                            passwordConfirmation:
                            passwordConfirmationController.text
                                .trim(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TxtStyle.font12wight400grey,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TxtStyle.font12wight400grey.copyWith(
                                color: ColorsManager.primaryColor,
                                fontWeight: FontWeight.w600,
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
