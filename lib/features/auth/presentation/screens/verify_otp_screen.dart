import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/auth/data/models/verify_otp_params.dart';
import 'package:craftybay/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:craftybay/features/auth/presentation/screens/sign_In_screen.dart';
import 'package:craftybay/features/auth/presentation/widgets/app_logo.dart';
import 'package:craftybay/features/common/presentation/widgets/center_circular_progress.dart';
import 'package:craftybay/features/common/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyOTpScreen extends StatefulWidget {
  const VerifyOTpScreen({super.key, required this.email});

  final String email;
  static const String name = '/verify_otp';

  @override
  State<VerifyOTpScreen> createState() => _VerifyOTpScreenState();
}

class _VerifyOTpScreenState extends State<VerifyOTpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  VerifyOtpProvider verifyOtpProvider = VerifyOtpProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create: (_) => verifyOtpProvider,
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

                      Text('Verify OTP', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
                      Text('A 4 digits otp has been sent to your email address', style: textTheme.bodyLarge,),

                      const SizedBox(height: 16),

                      PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldWidth: 50,
                          fieldHeight: 50
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        controller: _otpTEController,
                      ),

                      Consumer<VerifyOtpProvider>(
                        builder: (context,verifyOtpProvider,_ ) {
                          return Visibility(
                            visible: verifyOtpProvider.isVerifyOtpInProgress == false,
                            replacement: CenterCircularProgress(),
                            child: FilledButton(
                                onPressed: _onTapVerifyButton, child: Text('Verify OTP')),
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


  void _onTapSignInButton (){
    Navigator.pushReplacementNamed(context, SignInScreen.name);
    
  }
  void _onTapVerifyButton (){
  if(_formKey.currentState!.validate()){
    _verifyOtp();

  }
  }

  Future<void> _verifyOtp() async {
    final bool isSuccess = await verifyOtpProvider.verifyOtp(
        VerifyOtpParams(
            email: widget.email,
            otp: _otpTEController.text),

    );

    if(isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
    } else {
      showSnackBarMessage(context, verifyOtpProvider.errorMessage!);

    }
  }

}
