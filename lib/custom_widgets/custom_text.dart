import 'package:flutter/material.dart';

import '../utils/theme/app.colors.dart';
import '../utils/theme/app.fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;

  final Color? decorationColor;
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textDecoration,
      this.decorationColor,
      this.letterSpacing,
      this.maxLines,
      this.overflow,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.visible,
      style: TextStyle(
        fontSize: fontSize ?? AppFontSize.fontSize16,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.textBlack,
        fontFamily: "Horas",
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        letterSpacing: letterSpacing ?? 0,
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
