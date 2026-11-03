
import 'package:flutter/material.dart';
import 'package:craftybay/app/app_colors.dart';

import '../widgets/logout_dialog.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String name = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeader(
              name: 'User Name',
              email: 'user@email.com',
              onEditTap: () {
                // Edit Profile Screen navigation
              },
            ),

            const SizedBox(height: 20),

            ProfileSection(
              title: 'My Account',
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            ProfileSection(
              title: 'My Activities',
              children: [
                ProfileMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.favorite_border,
                  title: 'My Wishlist',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            ProfileSection(
              title: 'Support',
              children: [
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            ProfileSection(
              title: 'Account',
              children: [
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: Colors.red,
                  titleColor: Colors.red,
                  showArrow: false,
                  onTap: () => LogoutDialog.show(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}
