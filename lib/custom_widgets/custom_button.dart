import 'package:flutter/material.dart';

import '../utils/theme/app.colors.dart';
import '../utils/theme/app.fonts.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final String? assetName;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final bool isIcon;
  final double? buttonWidth;
  final double? buttonHeight;

  final BorderRadius? buttonRadius ;
  final Function() onTapFunction;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.assetName,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.isIcon = false,
    required this.onTapFunction,
    this.buttonWidth, this.buttonRadius, this.buttonHeight,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTapFunction,
      child: Container(
        height:widget.buttonHeight?? 46,
        width:widget. buttonWidth??size.width,
        decoration: BoxDecoration(
            color: widget.buttonColor ?? AppColors.appPrimary,
            borderRadius:widget.buttonRadius?? BorderRadius.circular(
              8,
            ),
            border:
                Border.all(color: widget.borderColor ?? AppColors.appPrimary)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: widget.text,
                color: widget.textColor ?? AppColors.appWhite,
                fontSize: AppFontSize.fontSize16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
