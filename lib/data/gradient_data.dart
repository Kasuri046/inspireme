import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class GradientData {
  static final List<List<Color>> lightGradients = [
    [AppColors.lightBlue.withOpacity(0.2), AppColors.lightCyan.withOpacity(0.2)],
    [AppColors.lightGreen.withOpacity(0.2), AppColors.lightTeal.withOpacity(0.2)],
    [AppColors.lightPurple.withOpacity(0.2), AppColors.lightPink.withOpacity(0.2)],
    [AppColors.lightOrange.withOpacity(0.2), AppColors.lightYellow.withOpacity(0.2)],
  ];

  static const List<List<Color>> darkGradients = [
    [AppColors.darkBlueGrey, AppColors.darkGrey],
    [AppColors.darkTeal, AppColors.darkBlueGrey],
    [AppColors.darkPurple, AppColors.darkIndigo],
    [AppColors.darkDeepOrange, AppColors.darkRedAccent],
  ];
}