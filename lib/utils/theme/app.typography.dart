import 'package:flutter/material.dart';
import 'app.fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle regularFootNote = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'Horas',
    fontSize: AppFontSize.fontSize12,
  );
  static TextStyle regularBodyTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: 'Horas',
    fontSize: AppFontSize.fontSize20,
  );
  static TextStyle menuTitle = TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Horas',
      fontSize: AppFontSize.fontSize16);
  static TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: 'Horas',
    fontSize: AppFontSize.fontSize18,
  );
  static TextStyle dialogTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: 'Horas',
    fontSize: AppFontSize.fontSize20,
  );
}
