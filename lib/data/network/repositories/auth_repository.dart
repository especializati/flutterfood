import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Exceptions/api_exception.dart';
import '../dio_client.dart';
import '../interceptors/dio_interceptor_auth.dart';
import '../../../models/User.dart';

class AuthRepository {
  Dio _dio = dioInterceptorAuth();
  FlutterSecureStorage storage = new FlutterSecureStorage();

  Future auth(String email, String password) async {
    try {
      String deviceName = await getIdentifyDevice();

      final response = await _dio.post('auth/token', data: {
        'email': email,
        'password': password,
        'device_name': deviceName
      });
      print(response.data);

      saveToken(response.data['token']);

      return response;
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
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
      Future.error({});

      ApiException(e.response);
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
      Future.error({});

      ApiException(e.response);
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

  Future<String> getIdentifyDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
  }
}
