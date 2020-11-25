import 'package:dio/dio.dart';

import './Exceptions/api_exception.dart';
import './interceptors/dio_interceptor.dart';

class DioClient {
  Dio _dio;

  DioClient() {
    _dio = dioInterceptor();
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic> queryParameters}) async {
    try {
      final Response response =
          await _dio.get(url, queryParameters: queryParameters);

      return response;
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
    }
  }

  Future<dynamic> post(String url,
      {formData, Map<String, dynamic> queryParameters}) async {
    try {
      final Response response = await _dio.post(url,
          data: formData, queryParameters: queryParameters);

      return response;
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
    }
  }
}
