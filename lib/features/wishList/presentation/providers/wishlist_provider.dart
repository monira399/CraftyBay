
import 'package:flutter/material.dart';
import '../../data/model/wishlist_model.dart';
import '../services/wishlist_service.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();

  List<WishlistItemModel> _wishlistItems = [];
  List<WishlistItemModel> get wishlistItems => _wishlistItems;

  bool _wishlistInProgress = false;
  bool get wishlistInProgress => _wishlistInProgress;

  bool _removeInProgress = false;
  bool get removeInProgress => _removeInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishlist() async {
    _wishlistInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _wishlistService.getWishlist();

      if (response.isSuccess) {
        final data = response.responseData['data'];
        final results = data['results'] as List;

        _wishlistItems = results
            .map(
              (item) => WishlistItemModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
            .toList();

        _errorMessage = null;
        return true;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _wishlistInProgress = false;
      notifyListeners();
    }
  }

  Future<bool> addToWishlist(String productId) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response =
      await _wishlistService.addToWishlist(productId);

      if (response.isSuccess) {
        await getWishlist();
        return true;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> removeFromWishlist(String wishlistItemId) async {
    _removeInProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response =
      await _wishlistService.removeFromWishlist(wishlistItemId);

      if (response.isSuccess) {
        _wishlistItems.removeWhere((item) => item.id == wishlistItemId);

        return true;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _removeInProgress = false;
      notifyListeners();
    }
  }
}
