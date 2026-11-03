
import 'package:flutter/material.dart';
import '../../../../app/constants.dart';
import '../../data/model/wishlist_model.dart';
import 'add_to_cart_button.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.item,
    required this.primaryColor,
    required this.removeInProgress,
    required this.isAdding,
    required this.onRemove,
    required this.onAddToCart,
  });

  final WishlistItemModel item;
  final Color primaryColor;
  final bool removeInProgress;
  final bool isAdding;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 108,
              height: 125,
              color: const Color(0xFFF4F5F7),
              child: item.imageUrl.isEmpty
                  ? const Icon(
                Icons.image_not_supported_outlined,
                size: 32,
              )
                  : Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    size: 32,
                  );
                },
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;

                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 13),

          // Product Information
          Expanded(
            child: SizedBox(
              height: 125,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Remove Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed:
                        removeInProgress ? null : onRemove,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red.shade400,
                          size: 21,
                        ),
                        tooltip: 'Remove from wishlist',
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Product Price
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${Constants.takaSign}${item.price.toStringAsFixed(0)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (item.oldPrice > 0) ...[
                        const SizedBox(width: 7),
                        Flexible(
                          child: Text(
                            '${Constants.takaSign}${item.oldPrice.toStringAsFixed(0)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 9),

                  // Add to Cart Button
                  AddToCartButton(
                    onPressed: onAddToCart,
                    isLoading: isAdding,
                    backgroundColor: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
