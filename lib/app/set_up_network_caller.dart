import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/auth/presentation/providers/auth_controllers.dart';

NetworkCaller getNetworkCaller(){
  NetworkCaller networkCaller =NetworkCaller(
      headers: {
        'Content-type' : 'application/json',
            'token': AuthController.accessToken ?? '',
      },
      onUnauthorize: (){

      }
      );
  return networkCaller;
}