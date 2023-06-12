import 'package:example/services/app_api.dart';
import 'package:example/services/response.dart';
import 'package:injectable/injectable.dart';

@injectable
class Repository {
  final Api _api;

  Repository(this._api);

  Future<BaseResponse?> getList(int page) async {
    try {
      BaseResponse result = (await _api.getList('6370acb911911e4f64bd09b67a7d3930', 'en', page));
      return result;
    } catch (e) {
      return null;
    }
  }
}
