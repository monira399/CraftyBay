
import 'package:craftybay/app/asset_paths.dart';
import 'package:craftybay/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'circle_icon_button.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AssetPaths.navLogoSvg),
      actions: [
        CircleIconButton(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.name);
          },
          icon: Icons.person,
        ),

        const SizedBox(width: 4),

        CircleIconButton(
          onTap: () {},
          icon: Icons.notifications_on_outlined,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
