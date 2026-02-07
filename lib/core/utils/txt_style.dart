import 'package:docdoc_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class TxtStyle {
  static const TextStyle font16wight600White = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: ColorsManager.white
  );
  static const TextStyle font24wight700Blue = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: ColorsManager.primaryColor
  );

  static const TextStyle font14wight400Grey = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorsManager.grey
  );
  static const TextStyle font14wight500Grey = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: ColorsManager.grey
  );
  static const TextStyle font24wight700primaryColor = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: ColorsManager.primaryColor,
  );

  static const TextStyle font12wight400grey = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: ColorsManager.grey,
    height: 1.4,
  );

  static const TextStyle font18wight700textDark = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: ColorsManager.textDark,
  );
}