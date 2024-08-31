import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvmbasic/providers/local_providers/local_provider.dart';
import 'package:mvvmbasic/providers/my_notifier.dart';

class LoadingController {

  bool isOpen = false;


  void openLoader() {
    if (isOpen) {
      ///if already loading will prevent open dialog
      return;
    }
    Get.dialog(
      const CircularProgressIndicator(),

      ///place loading widget here
    ).then((value) {
      /// here will find dialog close
      isOpen = false;
    });
    isOpen = true;
  }

  void closeLoader() {
    if (!isOpen) {
      /// check if dialog on screen else return
      return;
    }
    isOpen = false;
    LocaleProvider().backScreen();
  }
}
