import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'original_title')
  String? title;
  @JsonKey(name: 'release_date')
  String? date;
  @JsonKey(name: 'overview')
  String? overview;

  ApiResponse({this.title, this.date, this.overview});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'total_results')
  int? totalResults;

  @JsonKey(name: 'results')
  List<ApiResponse>? results;

  BaseResponse({this.page, this.totalPages, this.totalResults, this.results});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
