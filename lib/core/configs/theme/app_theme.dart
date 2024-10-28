import 'package:flutter/material.dart';
import 'package:mp3player/core/configs/theme/app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
  );
}
