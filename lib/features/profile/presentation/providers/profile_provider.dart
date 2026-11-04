
import 'package:flutter/material.dart';
import '../../../auth/data/models/user_model.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? _profileData;

  bool _isLoading = false;
  bool _isUpdating = false;

  String? _errorMessage;
  String? _successMessage;

  // Getters

  UserModel? get profileData => _profileData;

  bool get isLoading => _isLoading;

  bool get isUpdating => _isUpdating;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  // Get Profile

  Future<bool> getProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ProfileService.getProfile();

      if (response.isSuccess) {
        _profileData = UserModel.fromJson(
          response.responseData['data'],
        );

        return true;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Profile

  Future<bool> updateProfile({
    required Map<String, dynamic> body,
  }) async {
    _isUpdating = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await ProfileService.updateProfile(
        body: body,
      );

      if (response.isSuccess) {
        _profileData = UserModel.fromJson(
          response.responseData['data'],
        );

        _successMessage = response.responseData['msg'];

        return true;
      } else {
        _errorMessage = response.errorMassage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }
}
