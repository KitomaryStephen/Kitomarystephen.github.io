import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:signally/models/support.dart';

import '../utils_constants/app_constants.dart';

class ApiService {
  static String _baseUrl = AppConstants.BASE_URL_PROD;
  static Dio _dio = Dio();

  static Future<bool> sendSupportEmail({required Support support}) async {
    try {
      Response response = await _dio.post(_baseUrl + '/contact', data: {...support.toJson()});
      print(response.data);
      return true;
    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return false;
    }
  }
}
