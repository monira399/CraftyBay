
import 'package:flutter/material.dart';
import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/product/data/models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  static const int _pageSize = 30;

  int _currentPage = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;

  bool _moreLoading = false;
  bool get moreLoading => _moreLoading;

  bool _isFetching = false;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  // New Arrivals
  List<ProductModel> get newArrivalProducts {
    final sortedList = [..._productList];

    sortedList.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return sortedList.take(10).toList();
  }

  Future<bool> fetchProductList() async {
    if (_isFetching) return false;

    final int requestedPage = _currentPage + 1;

    if (_lastPageNo != null &&
        requestedPage > _lastPageNo!) {
      return false;
    }
    final bool isFirstPage = requestedPage == 1;

    _isFetching = true;
    _errorMessage = null;

    if (isFirstPage) {
      _productList.clear();
      _initialLoading = true;
    } else {
      _moreLoading = true;
    }

    notifyListeners();

    try {
      final NetworkResponse response =
      await getNetworkCaller().getRequest(
        url: Urls.productListUrl(
          _pageSize,
          requestedPage,
        ),
      );

      if (!response.isSuccess) {
        _errorMessage = response.errorMassage;
        return false;
      }

      final data = response.responseData['data'];

      _lastPageNo = data['last_page'] as int;

      final List<ProductModel> products =
      (data['results'] as List)
          .map(
            (item) => ProductModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList();

      _productList.addAll(products);
      _currentPage = requestedPage;

      return true;
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
      return false;
    } finally {
      _isFetching = false;
      _initialLoading = false;
      _moreLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProductList() async {
    if (_isFetching) return;

    _currentPage = 0;
    _lastPageNo = null;

    await fetchProductList();
  }
}
