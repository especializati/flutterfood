import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dio_client.dart';
import '../interceptors/dio_interceptor_auth.dart';
import '../../../models/User.dart';

class AuthRepository {
  Dio _dio = dioInterceptorAuth();
  FlutterSecureStorage storage = new FlutterSecureStorage();

  Future auth(String email, String password) async {
    try {
      final response = await _dio.post('auth/token', data: {
        'email': email,
        'password': password,
        'device_name': 'apenas_um_teste'
      });
      print(response.data);

      saveToken(response.data['token']);

      return response;
    } on DioError catch (e) {
      print(e.toString());
      print(e.response);
      print(e.response.statusCode);
      print(e.response.data);
    }
  }

  Future register(String name, String email, String password) async {
    try {
      final response = await _dio.post('auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      print(response.data);

      return response;
    } on DioError catch (e) {
      print(e.toString());
      print(e.response);
      print(e.response.statusCode);
      print(e.response.data);
    }
  }

  Future saveToken(String token) async {
    await storage.write(key: 'token_sanctum', value: token);
  }
}
