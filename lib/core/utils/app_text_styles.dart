import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const blackTitleStyle = TextStyle(
    fontSize: 18,
  );

  static const whiteTitleStyle = TextStyle(
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );

  static const whiteSubTitleStyle = TextStyle(
    fontSize: 14,
    color: AppColors.white,
  );

  static const buttonStyle = TextStyle(
    fontSize: 16,
    color: AppColors.white,
  );
}
