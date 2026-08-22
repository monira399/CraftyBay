import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/auth/data/models/verify_otp_params.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/sign_up_params.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _isVerifyOtpInProgress = false;

  bool get isVerifyOtpInProgress => _isVerifyOtpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(VerifyOtpParams params) async {
    bool isSuccess = false;

    _isVerifyOtpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(url: Urls.verifyOtpUrl,
        body: params.toJson(),
    );

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    }else {
      _errorMessage = response.errorMassage;
    }

    _isVerifyOtpInProgress = false;
    notifyListeners();

    return isSuccess ;
  }
}