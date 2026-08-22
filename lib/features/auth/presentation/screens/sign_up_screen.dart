import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/auth/data/models/sign_up_params.dart';
import 'package:craftybay/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_In_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/common/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/presentation/widgets/center_circular_progress.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpProvider signUpProvider = SignUpProvider();

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create:(_) => signUpProvider,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    spacing: 8,
                    children: [
                      AppLogo(width: 90,),
                      const SizedBox(height: 8),

                      Text('Sign Up', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
                      Text('Get started with your details', style: textTheme.bodyLarge,),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _firstNameTEController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'First name'
                        ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastNameTEController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Last name'
                        ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
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
                      TextFormField(
                        controller: _phoneTEController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Phone'
                        ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your phone number';
                          }
                          return null;
                        },
                      ),

                      TextFormField(
                        controller: _cityTEController,
                        decoration: InputDecoration(
                            hintText: 'City'
                        ),
                        validator: (String? value) {
                          if(value?.trim().isEmpty ?? true) {
                            return 'Enter your city';
                          }
                          return null;
                        },
                      ),

                      Consumer<SignUpProvider>(
                        builder: (context, signUpProvider, _) {
                          return Visibility(
                            visible: signUpProvider.isSignUpInProgress == false,
                            replacement: CenterCircularProgress(),
                            child: FilledButton(
                                onPressed: _onTapSignUpButton, child: Text('Sign Up')),
                          );
                        }
                      ),

                      const SizedBox(height: 8,),
                      RichText(text: TextSpan(
                        style: textTheme.bodyMedium,
                        text: 'Already have an account? ',
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold
                            ),
                            text: 'Sign In',
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
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

  void _onTapSignUpButton (){
    if(_formKey.currentState!.validate()) {}
    _signUp();

  }

  Future<void> _signUp() async {
    final bool isSuccess = await signUpProvider.signUp(
      SignUpParams(
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          email: _emailTEController.text.trim(),
          password: _passwordTEController.text.trim(),
          phone: _phoneTEController.text.trim(),
          city: _cityTEController.text.trim())
    );



    if(isSuccess){
      Navigator.pushNamed(context, VerifyOTpScreen.name, arguments: _emailTEController.text.trim());
    } else {
     showSnackBarMessage(context, signUpProvider.errorMessage!);
    }
  }
  void _onTapSignInButton (){
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}


