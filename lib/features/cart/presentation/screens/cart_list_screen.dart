import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/constants.dart';
import '../../../common/presentation/providers/main_nav_provider.dart';
import '../../widgets/cart_item.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return PopScope(
      onPopInvokedWithResult: (_, __){
        context.read<MainNavProvider>().backToHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text('Carts')),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CardItem();
                  },
                ),
              ),
            ),
            _buildTotalPriceAndCheckOutSection(textTheme),
          ],
        ),
      ),
    );
  }

  Container _buildTotalPriceAndCheckOutSection(TextTheme textTheme) {
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
                    '${Constants.takaSign}500',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  width:120 ,
                  child: FilledButton(onPressed: () {}, child: Text('CheckOut'))),
            ],
          ),
        );
  }
}


