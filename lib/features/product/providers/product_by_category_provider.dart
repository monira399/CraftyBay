import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/urls.dart';

class ProductListByCategoryProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPage = 0;

  int? _lastPageNo;

  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;

  bool _moreLoading = false;
  bool get moreLoading => _moreLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  Future<bool> fetchProductList(String categoryId) async {
    bool _isSuccess = false;

    if(_currentPage == 0) {
      _productList.clear();
      _initialLoading = true;
    } else if (_lastPageNo != null && _currentPage < _lastPageNo!) {
      _moreLoading = true;
    } else {
      return false;
    }
    notifyListeners();
    _currentPage++;

    final NetworkResponse response = await getNetworkCaller().getRequest(
        url:Urls.productByCategoryUrl(_pageSize, _currentPage, categoryId),
    );

    if (response.isSuccess) {
      _lastPageNo = response.responseData['data']['last_page'];

      List<ProductModel> list = [];

      for (
      Map<String, dynamic> jsonData
      in response.responseData['data']['results']
      ) {
        list.add(ProductModel.fromJson(jsonData));
      }

      _productList.addAll(list);
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    if(_initialLoading){
      _initialLoading = false;
    } else {
      _moreLoading = false;
    }

    notifyListeners();
    return _isSuccess;
  }

  Future<void> refreshProductList(String categoryId) async {
    _currentPage = 0;
    _lastPageNo = null;
    await fetchProductList(categoryId);
  }
}

