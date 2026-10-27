import 'package:craftybay/app/app_routes.dart';
import 'package:craftybay/app/providers/language_provider.dart';
import 'package:craftybay/app/providers/theme_provider.dart';
import 'package:craftybay/features/auth/presentation/screens/splash_screen.dart';
import 'package:craftybay/features/category/presentation/providers/category_list_provider.dart';
import 'package:craftybay/features/common/presentation/providers/main_nav_provider.dart';
import 'package:craftybay/features/home/presentation/provider/home_slider_providers.dart';
import 'package:craftybay/features/order/presentation/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../features/cart/presentation/provider/cart_provider.dart';
import '../l10n/app_localizations.dart';
import 'app_theme.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()..loadInitialLanguage()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadInitialThemeMode()),
        ChangeNotifierProvider(create: (_) => MainNavProvider()),
        ChangeNotifierProvider(create: (_) => CategoryListProvider()),
        ChangeNotifierProvider(create: (_) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (_) => CartItemProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                navigatorKey: CraftyBayApp.navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme ,
                themeMode: themeProvider.currentThemeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en'),
                  Locale('bn'),
                ],
                locale: languageProvider.currentLocale,


              );
            }
          );
        }
      ),
    );
  }
}
