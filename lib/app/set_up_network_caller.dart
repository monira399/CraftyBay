import 'package:craftybay/core/services/network_caller.dart';

NetworkCaller getNetworkCaller(){
  NetworkCaller networkCaller =NetworkCaller(
      headers: {
        'Content-type' : 'application/json',
            'token': 'token',
      },
      onUnauthorize: (){

      }
      );
  return networkCaller;
}