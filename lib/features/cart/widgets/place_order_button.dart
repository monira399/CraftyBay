
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({
    super.key,
    required this.onPressed,
    required this.textTheme,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final TextTheme textTheme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Place Order',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
