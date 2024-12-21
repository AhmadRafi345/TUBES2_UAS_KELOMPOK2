import 'package:flutter/foundation.dart';

class PrintLog {
  static void printLog(String message) {
    if (kDebugMode) {
      print("PrintLog: $message");
    }
  }
}
