import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/sign_up_params.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isSignUpInProgress = false;

  bool get isSignUpInProgress => _isSignUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp (SignUpParams params) async {
    bool isSuccess = false;

    _isSignUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.signUpUrl,body: params.toJson());

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else {
      _errorMessage = response.errorMassage;
    }

    _isSignUpInProgress = false;
    notifyListeners();

    return isSuccess ;
  }
}