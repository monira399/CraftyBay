import 'package:craftybay/features/product/presentation/screens/product_list_by_category.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductListByCategory.name);
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.themeColor.withAlpha(30),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(Icons.computer,size: 28,
                  color: AppColors.themeColor),
            ),
          ),
          Text('Computer', style:TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
              letterSpacing:3
          ))
        ],
      ),
    );
  }
}