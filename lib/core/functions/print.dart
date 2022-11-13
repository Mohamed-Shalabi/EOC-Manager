import 'package:flutter/foundation.dart';

void printInDebugMode(Object o) {
  if (kDebugMode) {
    print(o);
  }
}
