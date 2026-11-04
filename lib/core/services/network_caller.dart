import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
part '../models/network_response.dart';


class NetworkCaller{
   final Logger _logger = Logger();

   final VoidCallback onUnauthorize;
   final Map<String, String>? headers;

  NetworkCaller({required this.onUnauthorize, this.headers});

   Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri,
        headers: headers
      );
      _logResponse(url, response);

      _logger.i(url);
      print(response.statusCode);
      print(response.body);

      final int statusCode = response.statusCode;

      if(statusCode == 200 || statusCode == 201){
        //success
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData);
      } else if(statusCode == 401){
        onUnauthorize();
        return NetworkResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: null);
      }else {
        //failed
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMassage: decodedData['msg']

        );
      }
    } on Exception catch (e) {
      return NetworkResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMassage: e.toString()
      );
    }
  }

   Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);


      Response response = await post(uri,
          headers: headers,
          body: jsonEncode(body)
      );
      _logResponse(url, response);

      _logger.i(url);
      print(response.statusCode);
      print(response.body);

      final int statusCode = response.statusCode;

      if(statusCode == 200 || statusCode == 201){
        //success
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData);
      }else if(statusCode == 401){
        onUnauthorize();
        return NetworkResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: null,
            errorMassage: 'Un-authorize',
        );
      }else {
        //failed
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMassage: decodedData['msg'], // TODO: propose a solution to make this component independent

        );
      }
    } on Exception catch (e) {
      return NetworkResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMassage: e.toString()
      );
    }
  }


   Future<NetworkResponse> deleteRequest({
     required String url,
   }) async {
     try {
       Uri uri = Uri.parse(url);

       _logRequest(url);

       Response response = await delete(
         uri,
         headers: headers,
       );

       _logResponse(url, response);

       final int statusCode = response.statusCode;

       if (statusCode == 200 ||
           statusCode == 201 ||
           statusCode == 204) {
         dynamic decodedData;

         if (response.body.isNotEmpty) {
           decodedData = jsonDecode(response.body);
         }

         return NetworkResponse(
           isSuccess: true,
           responseCode: statusCode,
           responseData: decodedData,
         );
       } else if (statusCode == 401) {
         onUnauthorize();

         return NetworkResponse(
           isSuccess: false,
           responseCode: statusCode,
           responseData: null,
           errorMassage: 'Un-authorize',
         );
       } else {
         dynamic decodedData;

         if (response.body.isNotEmpty) {
           decodedData = jsonDecode(response.body);
         }

         return NetworkResponse(
           isSuccess: false,
           responseCode: statusCode,
           responseData: decodedData,
           errorMassage: decodedData is Map
               ? decodedData['msg']?.toString()
               : 'Request failed',
         );
       }
     } on Exception catch (e) {
       return NetworkResponse(
         isSuccess: false,
         responseCode: -1,
         responseData: null,
         errorMassage: e.toString(),
       );
     }
   }


   Future<NetworkResponse> patchRequest({
     required String url,
     required Map<String, dynamic> body,
   }) async {
     try {
       Uri uri = Uri.parse(url);

       _logRequest(url);

       Response response = await patch(
         uri,
         headers: headers,
         body: jsonEncode(body),
       );

       _logResponse(url, response);

       _logger.i(url);
       print(response.statusCode);
       print(response.body);

       final int statusCode = response.statusCode;

       if (statusCode == 200 || statusCode == 201) {
         // Success
         final decodedData = jsonDecode(response.body);

         return NetworkResponse(
           isSuccess: true,
           responseCode: statusCode,
           responseData: decodedData,
         );
       } else if (statusCode == 401) {
         onUnauthorize();

         return NetworkResponse(
           isSuccess: false,
           responseCode: statusCode,
           responseData: null,
         );
       } else {
         // Failed
         final decodedData = jsonDecode(response.body);

         return NetworkResponse(
           isSuccess: false,
           responseCode: statusCode,
           responseData: decodedData,
           errorMassage: decodedData['msg'],
         );
       }
     } on Exception catch (e) {
       return NetworkResponse(
         isSuccess: false,
         responseCode: -1,
         responseData: null,
         errorMassage: e.toString(),
       );
     }
   }





   void _logRequest (String url, { Map<String, dynamic>? body}){
    _logger.i('URL => $url\n'
        'Request Body : $body');
  }

   void _logResponse ( String url, Response response){
    _logger.i('URL => $url\n'
        'Status Code : ${response.statusCode}\n'
        'Body: ${response.body}');
  }

}


