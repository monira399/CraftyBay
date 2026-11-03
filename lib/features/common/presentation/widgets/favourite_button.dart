import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
    required this.onTap,
    this.isFavourite = false,
  });

  final VoidCallback onTap;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: AppColors.themeColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            isFavourite
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}