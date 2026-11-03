
import 'package:flutter/material.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({
    super.key,
    required this.primaryColor,
    required this.onExplore,
  });

  final Color primaryColor;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 52,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Your wishlist is empty',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Save your favorite products here and find them easily later.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: onExplore,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Explore Products'),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
