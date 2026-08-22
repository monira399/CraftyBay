import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/cart/presentation/screens/cart_list_screen.dart';
import 'package:craftybay/features/common/presentation/providers/main_nav_provider.dart';
import 'package:craftybay/features/home/presentation/screens/home_screen.dart';
import 'package:craftybay/features/wishList/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/screens/category_list_screen.dart';
class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main_nav_holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

final List<Widget> _screens =[
  HomeScreen(),
  CategoryListScreen(),
  CartListScreen(),
  WishListScreen(),

];

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavProvider>(
      builder: (context, mainNavProvider, _) {
        return Scaffold(
          body: _screens[mainNavProvider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.grey,
              selectedItemColor: AppColors.themeColor,
              currentIndex: mainNavProvider.selectedIndex,
              onTap: mainNavProvider.changeItem,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize), label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Carts'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded), label: 'Wishlist'),
              ]),
        );
      }
    );
  }
}



