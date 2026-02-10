import 'package:docdoc_app/core/utils/colors_manager.dart';
import 'package:docdoc_app/core/utils/txt_style.dart';
import 'package:flutter/material.dart';

class AppTxtFeild extends StatelessWidget {
  String hintTxt;
  TextEditingController textEditingController;
   AppTxtFeild({super.key,required this.hintTxt, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintTxt,
        hintStyle: TxtStyle.font14wight400Grey,
        fillColor:ColorsManager.txtFeildFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorsManager.txtFeildBorderColor,
          )
        )
      ),
    );
  }
}
