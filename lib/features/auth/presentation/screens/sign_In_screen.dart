import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/auth/data/models/signinparams.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/common/presentation/screens/main_nav_holder_screen.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/common/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sign_in_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  SignInProvider signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create: (_) => signInProvider,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 8,
                    children: [
                      AppLogo(width: 90,),
                      const SizedBox(height: 8),

                      Text('Sign In', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
                      Text('SignIn to your account with email and password', style: textTheme.bodyLarge,),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailTEController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email'
                        ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password'
                      ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your password ';
                          }
                          return null;
                        },),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: _onTapForgotPassword, child: Text('Forgot Password?'))
                        ],
                      ),

                      Consumer<SignInProvider>(
                          builder: (context, signInProvider, _) {
                            return Visibility(
                              visible: signInProvider.isSignInProgress == false,
                              replacement: CenterCircularProgress(),
                              child: FilledButton(
                                  onPressed: _onTapSignInButton, child: Text('Sign In')),
                            );
                          }
                      ),

                      const SizedBox(height: 8,),
                      RichText(text: TextSpan(
                        style: textTheme.bodyMedium,
                        text: 'Need an account? ',
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold
                            ),
                            text: 'Sign Up',
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                          ),
                        ]
                      ))
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void _onTapForgotPassword() {

  }
  void _onTapSignUpButton (){
    Navigator.pop(context);

  }
  void _onTapSignInButton (){
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  Future<void> _signIn() async {
    SignInParams params = SignInParams(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text.trim(),
    );
    final bool isSuccess = await signInProvider.signIn(params);
    if(isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, signInProvider.errorMessage!);
    }
  }
}
