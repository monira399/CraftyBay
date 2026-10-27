
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class CheckoutIconBox extends StatelessWidget {
  const CheckoutIconBox({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: Colors.black87,
      ),
    );
  }
}
