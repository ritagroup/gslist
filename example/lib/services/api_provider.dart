import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class ApiProvider {
  static Dio? _dio;

  static get dio {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 80),
          headers: {"Accept": "application/json"},
          receiveDataWhenStatusError: true,
          followRedirects: true,
          receiveTimeout: const Duration(seconds: 30),
          responseType: ResponseType.plain,
          contentType: 'application/json',
          validateStatus: (status) {
            return status as int <= 500;
          },
        ),
      );

      _dio?.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          compact: false,
          error: true,
          request: true));

      // setBearerHeader(_dio!, PrefHelper.get(PrefHelper.token) ?? '');
      // _dio!.interceptors.add(InterceptorsWrapper(onError: (error, handler) {}));
    }

    return _dio;
  }
}
