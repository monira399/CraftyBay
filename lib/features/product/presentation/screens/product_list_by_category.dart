import 'package:craftybay/features/common/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListByCategory extends StatefulWidget {
  const ProductListByCategory({super.key});

  static String name = '/product-list-by-category';

  @override
  State<ProductListByCategory> createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electronics')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8
          ),
          itemBuilder: (context, index) {
            return FittedBox(child: ProductCard());
          },
        ),

      ),
    );
  }
}
