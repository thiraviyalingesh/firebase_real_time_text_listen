import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class SnackBarHelper {
  OverlayEntry? _overlayEntry;
  Timer? _timer;

  showToast(
      String msg,
      bool isSuccess, {
        double gap = 16.0,
        double toastWidth = 300.0,
        Color? bgColor,
        Color? textColor,
        bool isImportant = false,
        bool autoDisable = true,
      }) {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    _timer?.cancel();

    final snackBar = GetSnackBar(
      messageText: Container(
        margin: const EdgeInsets.only(
          right: 20,
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: bgColor == Colors.yellow
                ? Colors.black
                : textColor ?? Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 3,
        ),
      ),
      icon: Icon(Icons.person,
          color: bgColor == Colors.yellow
              ? Colors.black
              : (textColor ?? Colors.white)),
      backgroundColor: bgColor ?? (isSuccess ? Colors.green : Colors.red),
      duration: const Duration(seconds: 3),
      borderRadius: 8.0,
    );
    final controller = AnimationController(
      vsync: Overlay.of(Get.overlayContext!),
      duration: const Duration(milliseconds: 500),
    );
    controller.forward();
    final screenWidth = MediaQuery.of(Get.overlayContext!).size.width;

    // Create a Paragraph object to measure the text width
    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.right,
      fontSize: 14.0, // Adjust font size as needed
    ))
      ..addText(msg);
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: screenWidth));
    const textWidth =
    100; // Placeholder width, you can adjust it based on your requirements

    final fadeTransition = FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 100,
      ).animate(
        CurvedAnimation(
          curve: Curves.easeOut,
          parent: controller,
        ),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              SizedBox(
                width: toastWidth,
                child: snackBar,
              ),
              Positioned(
                right: 10,
                top: 25,
                child: InkWell(
                  onTap: () {
                    _overlayEntry?.remove();
                    _overlayEntry?.dispose();
                    _overlayEntry = null;
                    _timer?.cancel();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: bgColor == Colors.yellow
                        ? Colors.black
                        : textColor ?? Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    _overlayEntry = OverlayEntry(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            //  height: 100,
            child: fadeTransition,
          ),
        ],
      ),
    );

    if (_overlayEntry != null) {
      Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
    }
    if (autoDisable) {
      _timer = Timer(
        const Duration(seconds: 3),
            () {
          _overlayEntry?.remove();
          _overlayEntry?.dispose();
          _overlayEntry = null;
        },
      );
    }
  }
}
