import 'package:flutter/material.dart';
import 'app_color.dart';
class AppTextStyles {
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.grey,
  );

  static const inputHint = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
  );
  
  static const label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const value = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
