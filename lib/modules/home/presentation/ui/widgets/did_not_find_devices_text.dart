import 'package:flutter/material.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';

class DidNotFindDevicesText extends StatelessWidget {
  const DidNotFindDevicesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyText(
      AppStrings.didNotFindDevices,
      style: AppTextStyles.whiteTitleStyle,
    );
  }
}
