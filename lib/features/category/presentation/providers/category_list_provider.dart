import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/urls.dart';

class CategoryListProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPage = 0;

  int? _lastPageNo;

  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;

  bool _moreLoading = false;
  bool get moreLoading => _moreLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList => _categoryList;

  Future<bool> fetchCategoryList() async {
    bool _isSuccess = false;

    if(_currentPage == 0) {
      _categoryList.clear();
      _initialLoading = true;
    } else if(_currentPage < _lastPageNo!) {
      _moreLoading = true;
    } else {
      return false;
    }
    notifyListeners();
    _currentPage++;

    final NetworkResponse response = await getNetworkCaller().getRequest(
        url:Urls.categoryListUrl(_pageSize, _currentPage));

    if(response.isSuccess){
      _lastPageNo ??= response.responseData['data']['last_page'];

      List<CategoryModel> list =[];
      for (Map<String, dynamic> jsonData in response.responseData['data']['results']) {
        list.add(CategoryModel.fromJson(jsonData));
      }
      _categoryList.addAll(list);
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

  Future<void> refreshCategoryList() async {
    _currentPage = 0;
    _lastPageNo = null;
    await fetchCategoryList();
  }
}

