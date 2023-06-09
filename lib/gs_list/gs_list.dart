import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gslist/gs_list/gs_list_controller.dart';
import 'package:gslist/gs_list/models/shimmer_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class GSList<T> extends StatefulWidget {
  GSList({
    Key? key,
    required this.controller,
    required this.onItemBuilder,
    required this.onLoadData,
    required this.itemCount,
    this.paginationEnable,
    this.height,
    this.emptyWidget,
    this.loadingWidget,
    this.scrollDirection,
    this.shrinkWrap,
    this.shimmerProperties,
    this.enableShimmerLoading,
    this.enablePullDownRefresh,
    this.physics,
  }) : super(key: key);

  final GSListController controller;
  final OnItemBuilder onItemBuilder;
  final OnLoadData onLoadData;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final ShimmerProperties? shimmerProperties;
  final bool? enableShimmerLoading;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final bool? enablePullDownRefresh;
  final bool? paginationEnable;

  int itemCount;

  @override
  State<GSList<T>> createState() => _GSListState<T>();
}

class _GSListState<T> extends State<GSList<T>> {
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    widget.controller.page = 1 ;
    widget.onLoadData(widget.controller.page) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () => const ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: (widget.controller.isLoading ?? true)
          ? _LoadingWidget(
              scrollDirection: widget.scrollDirection,
              simpleLoading: widget.loadingWidget,
              enableShimmer: widget.enableShimmerLoading,
              shimmerProperties: widget.shimmerProperties,
            )
          : _ListWidget(
              controller: widget.controller,
              onItemBuilder: widget.onItemBuilder,
              onLoadData: widget.onLoadData,
              itemCount: widget.itemCount,
              paginationEnable: widget.paginationEnable ?? false,
              height: widget.height,
              emptyWidget: widget.emptyWidget,
              loadingWidget: widget.loadingWidget,
              physics: widget.physics,
              scrollDirection: widget.scrollDirection,
              shrinkWrap: widget.shrinkWrap,
              enablePullDownRefresh: widget.enablePullDownRefresh ?? false,
              refreshController: refreshController,
            ),
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    Key? key,
    required this.controller,
    required this.onItemBuilder,
    required this.onLoadData,
    required this.refreshController,
    required this.itemCount,
    required this.paginationEnable,
    this.physics,
    this.scrollDirection,
    this.shrinkWrap,
    this.height,
    this.enablePullDownRefresh,
    this.emptyWidget,
    this.loadingWidget,
  }) : super(key: key);

  final GSListController controller;
  final OnItemBuilder onItemBuilder;
  final OnLoadData onLoadData;
  final int itemCount;
  final bool paginationEnable;

  final bool? enablePullDownRefresh;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SizedBox(height: height ?? double.infinity, child: emptyWidget);
    } else {
      return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () {
          controller.page = 1;
          controller.isLoading = true;
          onLoadData.call(controller.page);
          refreshController.refreshCompleted();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: physics,
                scrollDirection: scrollDirection ?? Axis.vertical,
                shrinkWrap: shrinkWrap ?? false,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (paginationEnable && index == itemCount - 1) {
                    controller.isLoading = true;
                    onLoadData.call(++controller.page);
                  }
                  return onItemBuilder(index);
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    Key? key,
    this.shimmerProperties,
    this.enableShimmer,
    this.simpleLoading,
    this.scrollDirection,
  }) : super(key: key);
  final ShimmerProperties? shimmerProperties;
  final Widget? simpleLoading;

  final Axis? scrollDirection;
  final bool? enableShimmer;

  @override
  Widget build(BuildContext context) {
    if ((enableShimmer ?? false) && shimmerProperties != null) {
      return ListView.builder(
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: shimmerProperties!.baseColor,
            highlightColor: shimmerProperties!.highlightColor,
            child: shimmerProperties!.child,
          );
        },
      );
    } else if (simpleLoading != null) {
      return Center(child: simpleLoading ?? Container());
    } else {
      return Container();
    }
  }
}

typedef OnItemBuilder = Widget Function(int index);
typedef OnLoadData = void Function(int nextPage);
