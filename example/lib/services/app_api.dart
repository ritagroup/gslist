// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:example/services/response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@injectable
@RestApi(baseUrl: 'https://api.themoviedb.org/3/')
abstract class Api {
  @factoryMethod
  factory Api(Dio _dio) => _Api(_dio, baseUrl: 'https://api.themoviedb.org/3/');

  @GET('discover/movie')
  Future<BaseResponse> getList(
    @Query('api_key') String apiKey,
    @Query('language') String language,
    @Query('page') int page,
  );
}
