import 'package:craftybay/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    late Widget widget;

    if(settings.name == SplashScreen.name) {
      widget = SplashScreen();
    }else {

    }
    return MaterialPageRoute(builder: (ctx) => widget);
  }
}