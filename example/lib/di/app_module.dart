import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../services/api_provider.dart';

@module
abstract class AppModule {
  Dio get dio => ApiProvider.dio;
}
