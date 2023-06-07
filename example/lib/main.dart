import 'package:flutter/material.dart';
import 'package:gslist/gs_list/gs_list.dart';
import 'package:gslist/gs_list/models/pull_down_refresh_option.dart';
import 'package:gslist/gs_list/models/shimmer_model.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GSList gsList;

  List<String> list = [
    'This is a sample for  gslist 1',
    'This is a sample for  gslist 2',
    'This is a sample for  gslist 3',
    'This is a sample for  gslist 4',
    'This is a sample for  gslist 5',
    'This is a sample for  gslist 6',
    'This is a sample for  gslist 7',
    'This is a sample for  gslist 8',
    'This is a sample for  gslist 9',
    'This is a sample for  gslist 10',
    'This is a sample for  gslist 11',
    'This is a sample for  gslist 12',
    'This is a sample for  gslist 13',
    'This is a sample for  gslist 14',
    'This is a sample for  gslist 15',
    'This is a sample for  gslist 16',
    'This is a sample for  gslist 17',
    'This is a sample for  gslist 18',
    'This is a sample for  gslist 19',
    'This is a sample for  gslist 20',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text(widget.title),
      ),
      body: gsList = GSList<String>(
        itemBuilder: (context, index) {
          return Item(
            model: list[index],
          );
        },
        loadMore: () {
          if(list.length<50) {
            List<String> temp = [
              'saeed 1',
              'saeed 2',
              'saeed 3',
              'saeed 4',
              'saeed 5',
              'saeed 6',
              'saeed 7',
              'saeed 8',
              'saeed 9',
              'saeed 10',
              'saeed 11',
              'saeed 12',
              'saeed 13',
              'saeed 14',
              'saeed 15',
              'saeed 16',
              'saeed 71',
              'saeed 18',
              'saeed 19',
              'saeed 20',
              'saeed 21',
              'saeed 22',
              'saeed 23',
              'saeed 24',
              'saeed 25',
              'saeed 26',
              'saeed 27',
              'saeed 28',
              'saeed 29',
              'saeed 30',
            ];
            list.addAll(temp);
            return list;
          }else {
            return list ;
          }

        },
        itemCount: list.length,
        isLoading: false,
        enableShimmerLoading: true,
        pullDownRefreshOption: PullDownRefreshOption(
          onLoading: (controller) {
            setState(() {});
            controller.refreshCompleted();
          },
          onRefresh: (controller) {
            setState(() {});
            controller.refreshCompleted();
          },
        ),
        controller: ScrollController(),
        emptyWidget: const Text('list is empty '),
        loadingWidget: const Text('loading please waite'),
        shimmerProperties:
            ShimmerProperties(baseColor: Colors.black12, highlightColor: Colors.white, child: const ItemShimmer()),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.model}) : super(key: key);

  final String model;

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
                  model,
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
