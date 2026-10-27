import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/constants.dart';
import '../../../common/presentation/providers/main_nav_provider.dart';
import '../../widgets/cart_item.dart';
import 'checkout_screen.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!mounted) return;
      context.read<CartItemProvider>().getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final provider = context.watch<CartItemProvider>();
    return PopScope(
      onPopInvokedWithResult: (_, __){
        context.read<MainNavProvider>().backToHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text('Carts')),
        body: Consumer<CartItemProvider>(
          builder: (context, provider, _) {
            if(provider.cartItemInProgress) {
              return Center(child: CircularProgressIndicator(),
              );
            }

            if(provider.errorMessage != null){
              return Center(child: Text(provider.errorMessage!),
              );
            }

            if(provider.cartItems.isEmpty) {
              return const Center(
                child: Text('Your cart is empty'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: provider.cartItems.length,
                      itemBuilder: (context, index) {
                        return CardItem(cartItem: provider.cartItems[index],
                          onQuantityChanged: (quantity) {
                          provider.updateQuantity(index, quantity);
                          },);
                      },
                    ),
                  ),
                ),
                _buildTotalPriceAndCheckOutSection(textTheme, provider.totalPrice),
              ],
            );
          }
        ),
      ),
    );
  }

  Container _buildTotalPriceAndCheckOutSection(TextTheme textTheme, num totalPrice) {
    return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.themeColor.withAlpha(48),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Price', style: textTheme.bodyLarge),
                  Text(
                    '${Constants.takaSign}$totalPrice',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  width:120 ,
                  child: FilledButton(onPressed: () {
                    Navigator.pushNamed(context, CheckoutScreen.name);
                  }, child: Text('CheckOut'))),
            ],
          ),
        );
  }
}


