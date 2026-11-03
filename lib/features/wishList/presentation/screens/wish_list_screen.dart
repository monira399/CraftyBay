
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../common/presentation/providers/add_to_cart_provider.dart';
import '../../data/model/wishlist_model.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/empty_wishlist_widget.dart';
import '../widgets/wishlist_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String? _addingProductId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().getWishlist();
    });
  }

  // Remove product from wishlist
  Future<void> _removeProduct(WishlistItemModel item) async {
    final wishlistProvider = context.read<WishlistProvider>();

    try {
      final isSuccess =
      await wishlistProvider.removeFromWishlist(item.id);

      if (!mounted) return;

      _showMessage(
        isSuccess
            ? '${item.title} removed from wishlist!'
            : wishlistProvider.errorMessage ??
            'Failed to remove from wishlist',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage('Something went wrong. Please try again.');
    }
  }
  // Add selected product to cart
  Future<void> _addToCart(WishlistItemModel item) async {
    if (_addingProductId != null) return;

    setState(() {
      _addingProductId = item.productId;
    });

    try {
      final cartProvider = context.read<AddToCartProvider>();

      final isSuccess =
      await cartProvider.addToCart(item.productId);

      if (!mounted) return;

      _showMessage(
        isSuccess
            ? '${item.title} added to cart!'
            : cartProvider.errorMessage ?? 'Failed to add to cart',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage('Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _addingProductId = null;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = AppColors.themeColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Wishlist',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${provider.wishlistItems.length} items',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: Consumer<WishlistProvider>(
        builder: (context, provider, _) {
          // Initial loading
          if (provider.wishlistInProgress &&
              provider.wishlistItems.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (provider.errorMessage != null &&
              provider.wishlistItems.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => provider.getWishlist(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Empty state
          if (provider.wishlistItems.isEmpty) {
            return EmptyWishlistWidget(
              primaryColor: primaryColor,
              onExplore: () => Navigator.pop(context),
            );
          }
          // Wishlist product list
          return RefreshIndicator(
            onRefresh: provider.getWishlist,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: provider.wishlistItems.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = provider.wishlistItems[index];

                return WishlistProductCard(
                  item: item,
                  primaryColor: primaryColor,
                  removeInProgress: provider.removeInProgress,
                  isAdding: _addingProductId == item.productId,
                  onRemove: () => _removeProduct(item),
                  onAddToCart: () => _addToCart(item),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
