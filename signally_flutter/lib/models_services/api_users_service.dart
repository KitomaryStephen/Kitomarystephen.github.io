import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils_constants/app_constants.dart';

class ApiUsersService {
  static String _baseUrl = AppConstants.BASE_URL_PROD;
  static Dio _dio = Dio();

  static Future<bool?> deleteAccount() async {
    try {
      User? fbUser = FirebaseAuth.instance.currentUser;
      String? jsonWebToken = await fbUser?.getIdToken();
      if (jsonWebToken == null) return null;

      await _dio.patch(_baseUrl + '/users/userId/${fbUser?.uid}/delete-account',
          data: {'jsonWebToken': jsonWebToken}, options: Options(receiveTimeout: 5000));

      FirebaseAuth.instance.signOut();

      return true;
    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return false;
    }
  }
}
