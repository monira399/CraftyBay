part of '../services/network_caller.dart';

class NetworkResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMassage;

  NetworkResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMassage = 'Something Went Wrong',
  });
}