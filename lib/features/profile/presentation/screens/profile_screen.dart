
import 'package:craftybay/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:craftybay/app/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../order/presentation/screens/order_history_screen.dart';
import '../providers/profile_provider.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile();
    });
  }
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
            Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                final data = provider.profileData;

                return ProfileHeader(
                  name: data == null
                      ? 'Loading...'
                      : '${data.firstName} ${data.lastName}',
                  email: data?.email ?? '',
                  onEditTap: () {
                    Navigator.pushNamed(
                      context,
                      PersonalInfoScreen.name,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            ProfileSection(
              title: 'My Account',
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PersonalInfoScreen.name,
                    );
                  },
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyOrdersScreen(),
                      ),
                    );
                  },
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
