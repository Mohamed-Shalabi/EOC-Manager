import 'package:flutter/material.dart';

extension NavigatorUtil on BuildContext {
  Future<T?> navigate<T extends Object?>(Widget screen) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}
