import 'package:flutter/material.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';
import 'package:craftybay/features/common/presentation/widgets/product_card.dart';

import 'section_haeder.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onTapSeeAll,
    this.isLoading = false,
    this.isGrid = false,
    required this.onFavouriteTap,
    this.showSeeAll = true,
  });

  final String title;
  final List<ProductModel> products;
  final VoidCallback onTapSeeAll;
  final bool isLoading;
  final bool isGrid;
  final void Function(ProductModel product) onFavouriteTap;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showSeeAll)
          SectionHeader(
            title: title,
            onTapSeeAll: onTapSeeAll,
          )
        else
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 12),

        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (products.isEmpty)
          const Center(child: Text('No products found'))
        else if (isGrid)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  productModel: products[index],
                  isGrid: true,
                  onFavouriteTap: () => onFavouriteTap(products[index]),
                );
              },
            )
          else
            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    productModel: products[index],
                    onFavouriteTap: () => onFavouriteTap(products[index]),
                  );
                },
                separatorBuilder: (_, __) =>
                const SizedBox(width: 8),
              ),
            ),
      ],
    );
  }
}