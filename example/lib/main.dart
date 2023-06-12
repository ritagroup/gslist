import 'package:example/di/di.dart';
import 'package:example/services/response.dart';
import 'package:example/view_models/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gslist/gs_list/gs_list.dart';
import 'package:gslist/gs_list/models/shimmer_model.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  late MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Get.put(MainViewModel());

    return GetBuilder<MainViewModel>(
      builder: (GetxController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white54,
            title: Text(title),
          ),
          body: GSList<ApiResponse>(
            controller: viewModel.controller,
            onItemBuilder: (index) {
              return Item(
                model: viewModel.items[index],
              );
            },
            onLoadData: (int nextPage) {
              viewModel.getList(nextPage);
            },
            itemCount: viewModel.items.length,
            enableShimmerLoading: true,
            emptyWidget: const Text('list is empty '),
            loadingWidget: const Text('loading please waite'),
            shimmerProperties:
                ShimmerProperties(baseColor: Colors.black12, highlightColor: Colors.white, child: const ItemShimmer()),
          ),
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.model}) : super(key: key);

  final ApiResponse model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.ac_unit,
              color: Colors.blue,
              size: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Center(
                widthFactor: 1,
                child: Text(
                  model.title ?? '',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemShimmer extends StatelessWidget {
  const ItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Center(
                  widthFactor: 1,
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
