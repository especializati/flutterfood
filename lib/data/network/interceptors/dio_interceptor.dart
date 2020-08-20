import 'package:dio/dio.dart';

import '../../../contants/api.dart';

Dio dioInterceptor() {
  Dio dio = new Dio();

  // Set default configs
  dio.options.baseUrl = API_URL;
  dio.options.connectTimeout = API_CONNECTION_TIMEOUT; //5s
  dio.options.receiveTimeout = API_RECEIVE_TIMEOUT;

  return dio;
}
