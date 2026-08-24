import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/home/data/models/slider_model.dart';
import 'package:flutter/cupertino.dart';

class HomeSliderProvider extends ChangeNotifier {
  bool _getHomeSliderInProgress = false;

  bool get getHomeSliderInProgress => _getHomeSliderInProgress;

  List<SliderModel> _homeSliders = [];
  List<SliderModel> get homeSliders => _homeSliders;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeSlider() async {
    bool isSuccess = false;
    _getHomeSliderInProgress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.homeSliderUrl);

    if(response.isSuccess) {
      List<SliderModel> sliders=[];
      for(Map<String, dynamic> slider in response.responseData['data']['results']) {
        sliders.add(SliderModel.fromJson(slider));
      }
      _homeSliders = sliders;
      isSuccess = true;

    } else {
      _errorMessage = response.errorMassage;
      return false;
    }

    _getHomeSliderInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}