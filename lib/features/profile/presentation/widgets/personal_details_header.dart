
import 'package:flutter/material.dart';
import 'package:craftybay/app/app_colors.dart';

class PersonalDetailsHeader extends StatelessWidget {
  const PersonalDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor:
            AppColors.themeColor.withValues(alpha: 0.1),
            child: Icon(
              Icons.person_outline,
              size: 38,
              color: AppColors.themeColor,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Update your personal information',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
