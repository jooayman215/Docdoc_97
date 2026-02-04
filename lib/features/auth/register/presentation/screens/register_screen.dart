import 'package:docdocapp97/core/utils/colors_manager.dart';
import 'package:docdocapp97/core/utils/txt_style.dart';
import 'package:docdocapp97/core/widgets/app_button.dart';
import 'package:docdocapp97/core/widgets/app_txt_feild.dart';
import 'package:docdocapp97/features/auth/register/data/user_model.dart';
import 'package:docdocapp97/features/auth/register/logic/cubit.dart';
import 'package:docdocapp97/features/auth/register/logic/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordConfirmationController =
  TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Account created successfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.primaryColor,
               // duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );

          } else if (state is RegisterErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: ColorsManager.primaryColor,
                //duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
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
                        hintTxt: "name", textEditingController: nameController),
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
                    (state is RegisterLoadingState) ?Center(child: CircularProgressIndicator())  : AppButton(
                      buttonTxt: "Create Account",
                      function: () {
                        context.read<RegisterCubit>().register(
                          UserModel(
                            email: emailController.text,
                            name: nameController.text,
                            gender: genderController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                            passwordConfirmation: passwordConfirmationController
                                .text,
                          ),
                        );
                      },
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
