import 'package:example/di/di.dart';
import 'package:example/repository/repository.dart';
import 'package:example/services/response.dart';
import 'package:get/get.dart';
import 'package:gslist/gs_list/gs_list_controller.dart';

class MainViewModel extends GetxController {
  List<ApiResponse> items = [];
  GSListController controller = GSListController();

  getList(int page) async {
    BaseResponse? result = await getIt<Repository>().getList(page);
    items.addAll(result!.results!);
    controller.isLoading = false;
    update();
  }
}
