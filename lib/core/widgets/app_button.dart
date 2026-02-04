import 'package:docdocapp97/core/utils/colors_manager.dart';
import 'package:docdocapp97/core/utils/txt_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String buttonTxt;
  Function function;
   AppButton({super.key,required this.buttonTxt,required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=>function(),
      child: Container(
        width: 327,
        height: 52,
        decoration: BoxDecoration(
          color:ColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: Text(buttonTxt,style: TxtStyle.font16wight600White,)),
      ),
    );
  }
}
