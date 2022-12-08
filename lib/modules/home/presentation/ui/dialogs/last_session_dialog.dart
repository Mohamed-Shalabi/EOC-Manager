import 'package:flutter/material.dart';

void showLastSessionDialog(BuildContext context, int height) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          'Last height was $height, do you want to send it now?',
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}
