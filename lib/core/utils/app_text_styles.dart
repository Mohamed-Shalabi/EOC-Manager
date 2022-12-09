import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static const titleStyle = TextStyle(
    fontSize: 18,
  );

  static const buttonStyle = TextStyle(
    fontSize: 24,
    color: AppColors.white,
  );

  static const warningStyle = TextStyle(
    fontSize: 20,
    color: AppColors.red,
  );
}
