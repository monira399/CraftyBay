import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.showArrow = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.black54,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: titleColor ?? Colors.black87,
        ),
      ),
      trailing: showArrow
          ? const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.grey,
      )
          : null,
    );
  }
}