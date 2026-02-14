import 'package:flutter/material.dart';

import '../utils/colors_manager.dart';
import '../utils/txt_style.dart';

class PassTxtFeild extends StatefulWidget {
  String hintTxt;
  TextEditingController textEditingController;
  PassTxtFeild({super.key, required this.textEditingController,required this.hintTxt});

  @override
  State<PassTxtFeild> createState() => _PassTxtFeildState();
}

class _PassTxtFeildState extends State<PassTxtFeild> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: showPass ? false : true,
      controller: widget.textEditingController,

      decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              showPass = !showPass;
            });
          }, icon: Icon(showPass ? Icons.visibility : Icons.visibility_off)),

          hintText: widget.hintTxt,
          hintStyle: TxtStyle.font14Weight400Grey,
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