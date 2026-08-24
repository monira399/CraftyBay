import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/product/data/models/product_details_model.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';
import 'package:flutter/widgets.dart';

import '../../../app/urls.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool _getProductDetailsInProgress = false;
  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  ProductDetailsModel? _productDetailsModel;
  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

 Future<bool> getProductDetails(String productId) async {
   bool isSuccess = false;

   _getProductDetailsInProgress = true;
   notifyListeners();
   final NetworkResponse response = await getNetworkCaller().getRequest(url: Urls.productDetailsUrl(productId),
   );

   if(response.isSuccess){
     _productDetailsModel = ProductDetailsModel.fromJson(response.responseData['data']);
     isSuccess = true;
     _errorMessage = null;
 } else {
     _errorMessage = response.errorMassage;
   }
   _getProductDetailsInProgress = false;
   notifyListeners();
   return isSuccess;
 }
}