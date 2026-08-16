import 'package:craftybay/app/app_routes.dart';
import 'package:craftybay/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //router
      // theme
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme ,
      themeMode: ThemeMode.light,
    );
  }
}
