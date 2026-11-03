import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/home/presentation/provider/home_slider_providers.dart';
import 'package:craftybay/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/presentation/providers/main_nav_provider.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/providers/product_list_provider.dart';
import '../../../wishList/presentation/providers/wishlist_provider.dart';
import '../widgets/category_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/product_search_field.dart';
import '../widgets/product_section.dart';
import '../widgets/section_haeder.dart';

//// Token
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2YWUyZDNkMTEwM2Q0NzNiNWIyODI0ZmQiLCJmaXJzdF9uYW1lIjoibW9uaSIsImxhc3RfbmFtZSI6InJhIiwiZW1haWwiOiJtb25pMTJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInBob25lIjoiMDE0NTk3NjI1NSIsInBob25lX3ZlcmlmaWVkIjpmYWxzZSwiYXZhdGFyX3VybCI6bnVsbCwiY2l0eSI6ImRoYWthIiwicm9sZSI6MCwiaWF0IjoxNzkzNTI2OTA1LCJleHAiOjE3OTQxMzE3MDV9.OXPtnk10-tguCOowQMrxaK-BSv3swKBmAszCAMjmB-g

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListProvider>().fetchProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Search
            const ProductSearchField(),

            const SizedBox(height: 16),

            // Home Slider
            Consumer<HomeSliderProvider>(
              builder: (context, provider, _) {
                if (provider.getHomeSliderInProgress) {
                  return const SizedBox(
                    height: 200,
                    child: CenterCircularProgress(),
                  );
                }

                return HomeCarouselSlider(sliders: provider.homeSliders);
              },
            ),

            const SizedBox(height: 24),

            SectionHeader(
              title: 'Categories',
              onTapSeeAll: () {
                context.read<MainNavProvider>().changeCategories();
              },
            ),

            const SizedBox(height: 12),

            const CategorySection(),
            const SizedBox(height: 24),

            // New Arrivals
            Consumer<ProductListProvider>(
              builder: (context, provider, child) {
                return ProductSection(
                  title: 'New Arrivals',
                  products: provider.newArrivalProducts,
                  isLoading: provider.initialLoading,
                  onTapSeeAll: () {},
                  showSeeAll: false,
                  onFavouriteTap: _AddToWishlist,
                );
              },
            ),

            const SizedBox(height: 24),
            // All Products
            Consumer<ProductListProvider>(
              builder: (context, provider, child) {
                return ProductSection(
                  title: 'All Products',
                  products: provider.productList,
                  isLoading: provider.initialLoading,
                  onTapSeeAll: () {},
                  onFavouriteTap: _AddToWishlist,
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _AddToWishlist(ProductModel product) async {
    final wishlistProvider = context.read<WishlistProvider>();

    final isSuccess = await wishlistProvider.addToWishlist(product.id);

    if (!mounted) return;

    _showMessage(
      isSuccess
          ? '${product.title} added to wishlist!'
          : wishlistProvider.errorMessage ?? 'Failed to add to wishlist',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
