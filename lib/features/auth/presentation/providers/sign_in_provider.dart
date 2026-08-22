import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/auth/data/models/signinparams.dart';
import 'package:craftybay/features/auth/data/models/user_model.dart';
import 'package:craftybay/features/auth/presentation/providers/auth_controllers.dart';
import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  bool _isSignInProgress = false;

  bool get isSignInProgress => _isSignInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn (SignInParams params) async {
    bool isSuccess = false;

    _isSignInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.signInUrl,body: params.toJson());

    if(response.isSuccess){
      UserModel model =  UserModel.fromJson(response.responseData['data']['user']);
      String accessToken = response.responseData['data']['token'];
      await AuthController.saveUserData(accessToken, model);

      isSuccess = true;
      _errorMessage = null;
    }else {
      _errorMessage = response.errorMassage;
    }

    _isSignInProgress = false;
    notifyListeners();

    return isSuccess ;
  }
}