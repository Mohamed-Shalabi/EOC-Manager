import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.white,
    );
  }
}
