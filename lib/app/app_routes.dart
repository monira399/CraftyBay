import 'package:craftybay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/splash_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:craftybay/features/common/presentation/screens/main_nav_holder_screen.dart';
import 'package:craftybay/features/product/presentation/screens/product_list_by_category.dart';
import 'package:craftybay/features/product/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_In_screen.dart';
import '../features/category/data/models/category_model.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
     late Widget widget;

    if(settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if(settings.name == SignUpScreen.name) {
      widget = SignUpScreen();
    } else if(settings.name == SignInScreen.name) {
      widget = SignInScreen();
    } else if(settings.name == VerifyOTpScreen.name) {
      final email = settings.arguments as String;
      widget = VerifyOTpScreen(email: email,);
    }else if(settings.name == MainNavHolderScreen.name) {
      widget = MainNavHolderScreen();
    } else if(settings.name == ProductListByCategory.name) {
      final categoryModel = settings.arguments as CategoryModel;
      widget = ProductListByCategory(categoryModel: categoryModel);
    } else if(settings.name == ProductsDetailsScreen.name) {
      final productId = settings.arguments as String;
      widget = ProductsDetailsScreen(productId: productId);
    } else {
      widget = const Scaffold(
        body: Center(
          child: Text('Route not found'),
        ),
      );
    }

     return MaterialPageRoute(builder: (ctx) => widget);
  }
}