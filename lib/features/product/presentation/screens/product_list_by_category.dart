import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/common/presentation/widgets/product_card.dart';
import 'package:craftybay/features/product/providers/product_by_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../wishList/presentation/providers/wishlist_provider.dart';
import '../../data/models/product_model.dart';
class ProductListByCategory extends StatefulWidget {
  const ProductListByCategory({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  static String name = '/product-list-by-category';

  @override
  State<ProductListByCategory> createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {

  final ProductListByCategoryProvider _productListByCategoryProvider = ProductListByCategoryProvider();
  final ScrollController _scrollController = ScrollController();

  Future<void> _addToWishlist(ProductModel product) async {
    final wishlistProvider = context.read<WishlistProvider>();

    final isSuccess =
    await wishlistProvider.addToWishlist(product.id);

    if (!mounted) return;

    _showMessage(
      isSuccess
          ? '${product.title} added to wishlist!'
          : wishlistProvider.errorMessage ?? 'Failed to add to wishlist',
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListByCategoryProvider.refreshProductList(
        widget.categoryModel.id,
      );
      _scrollController.addListener(_loadMoreData);
    });
  }

  void _loadMoreData() {
    if(_productListByCategoryProvider.moreLoading){
      return;
    }
    if(_scrollController.position.extentBefore < 300) {
      _productListByCategoryProvider.fetchProductList(widget.categoryModel.id);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryModel.title)),
      body: ChangeNotifierProvider(
        create: (_) => _productListByCategoryProvider,
        child: Consumer<ProductListByCategoryProvider>(
          builder: (context, _,_) {
            if(_productListByCategoryProvider.initialLoading){
              return CenterCircularProgress();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _productListByCategoryProvider.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 8
                ),
                itemBuilder: (context, index) {
                  final product = _productListByCategoryProvider.productList[index];
                  return FittedBox(
                    child: ProductCard(
                      productModel: product,
                      onFavouriteTap: () => _addToWishlist(product)
                    ),
                  );
                },
              ),

            );
          }
        ),
      ),
    );
  }
}
