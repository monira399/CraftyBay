import 'package:craftybay/features/auth/presentation/providers/auth_controllers.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_In_screen.dart';
import 'package:craftybay/features/common/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    final isLoggedIn = await AuthController.isAlreadyLoggedIn();

    await Future.delayed(Duration(seconds: 2));
    if(isLoggedIn){
      await AuthController.getUserData();
    }

    if (!mounted) return;

    if(isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolderScreen.name,
            (predicate) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
            (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 16,)
          ],
        ),

      ),
    );
  }
}

