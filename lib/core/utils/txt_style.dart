import 'package:docdocapp97/core/utils/colors_manager.dart';
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
}