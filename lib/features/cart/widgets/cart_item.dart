import 'package:craftybay/features/cart/data/%20models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/asset_paths.dart';
import '../../../app/constants.dart';
import '../presentation/screens/increment_decrement_button.dart';

class CardItem extends StatelessWidget {
  final CartItemModel cartItem;
  final ValueChanged<int> onQuantityChanged;
  const CardItem({super.key, required this.cartItem, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final product = cartItem.product;

    return Card(
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(50),
      color: Colors.white,
      child: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: product.photo.isNotEmpty
                ? Image.network(
                    product.photo,
                    height: 80,
                    width: 60,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 80,
                        width: 60,
                        child: Icon(Icons.image_not_supported),
                      );
                    },
                  )
                : const SizedBox(
                    height: 80,
                    width: 60,
                    child: Icon(Icons.image_not_supported),
                  ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           product.title,
                            maxLines: 1,
                            style: textTheme.bodyLarge?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Constants.takaSign}${product.currentPrice}',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.themeColor,
                      ),
                    ),
                    IncrementDecrementButton(
                        initialValue: cartItem.quantity,
                        onChanged: onQuantityChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
