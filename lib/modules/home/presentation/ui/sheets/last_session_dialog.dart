import 'package:flutter/material.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_strings.dart';

void showLastSessionDialog(BuildContext context, int height) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          AppStrings.getLastSessionMessage(height),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const MyText(AppStrings.yes),
          ),
          TextButton(
            onPressed: () {},
            child: const MyText(AppStrings.no),
          ),
        ],
      );
    },
  );
}
