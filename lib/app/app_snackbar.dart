import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.themeColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
