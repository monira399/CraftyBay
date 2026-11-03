
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:craftybay/features/category/presentation/providers/category_list_provider.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/common/presentation/widgets/category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Consumer<CategoryListProvider>(
        builder: (context, provider, _) {
          if (provider.initialLoading) {
            return const CenterCircularProgress();
          }

          if (provider.categoryList.isEmpty) {
            return const Center(
              child: Text('No categories found'),
            );
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categoryList.length > 10
                ? 10
                : provider.categoryList.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                categoryModel: provider.categoryList[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 8);
            },
          );
        },
      ),
    );
  }
}
