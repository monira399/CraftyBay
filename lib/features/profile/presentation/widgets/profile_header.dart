
import 'package:craftybay/features/profile/presentation/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:craftybay/app/app_colors.dart';
import 'profile_avatar.dart';
import 'edit_profile_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.onEditTap,
  });

  final String name;
  final String email;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const ProfileAvatar(),
          const SizedBox(height: 12),

          ProfileInfo(
            name: name,
            email: email,
          ),

          const SizedBox(height: 14),

          EditProfileButton(
            onTap: onEditTap,
          ),
        ],
      ),
    );
  }
}
