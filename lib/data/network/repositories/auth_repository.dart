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

  Future<User> getMe() async {
    final String token = await storage.read(key: 'token_sanctum');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer ' + token;
    }

    try {
      final response = await _dio.get('auth/me');
      print(response.data);

      return User.fromJson(response.data['data']);
    } on DioError catch (e) {
      print(e.toString());
      print(e.response);
      print(e.response.statusCode);
      print(e.response.data);
    }
  }

  Future logout() async {
    await DioClient().post('auth/logout');

    await deleteToken();
  }

  Future saveToken(String token) async {
    await storage.write(key: 'token_sanctum', value: token);
  }

  Future deleteToken() async {
    await storage.delete(key: 'token_sanctum');
  }
}
