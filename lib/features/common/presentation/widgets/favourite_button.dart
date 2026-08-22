import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: AppColors.themeColor,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(Icons.favorite_outline_rounded,size: 16, color: Colors.white,),
      ),
    );
  }
}