
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class CheckoutSectionTitle extends StatelessWidget {
  const CheckoutSectionTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.textTheme,
  });

  final String title;
  final IconData icon;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.themeColor,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
