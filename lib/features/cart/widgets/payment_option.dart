
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.selectedPaymentMethod,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String selectedPaymentMethod;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedPaymentMethod,
      activeColor: AppColors.themeColor,
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      onChanged: onChanged,
    );
  }
}
