import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class GlobalFunctions {
  static SnackbarController showGetToast(String msg, bool isSuccess) {
    return Get.snackbar(
      "",
      msg,
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
  }

  static showToast(String msg, bool issuccess) {
    showGetToast(msg, issuccess);
  }

  static showDialogLocal(Widget child) {
    Get.dialog(child);
  }
}


myPrint(value,String tag) {
  if (kDebugMode) {
    print(value);
  }
}