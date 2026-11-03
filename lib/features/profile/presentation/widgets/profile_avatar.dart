
import 'package:flutter/material.dart';
import 'package:craftybay/app/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 55,
            color: AppColors.themeColor,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 17,
              color: AppColors.themeColor,
            ),
          ),
        ),
      ],
    );
  }
}
