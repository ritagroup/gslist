import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gslist/gs_list/models/pull_down_refresh_option.dart';
import 'package:gslist/gs_list/models/shimmer_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class GSList<T> extends StatefulWidget {
  GSList({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.controller,
    this.physics,
    this.scrollDirection,
    this.shrinkWrap,
    this.keyboardDismissBehavior,
    this.height,
    this.isLoading,
    this.shimmerProperties,
    this.enableShimmerLoading,
    this.enablePullDownRefresh,
    this.pullDownRefreshOption,
    this.emptyWidget,
    this.loadingWidget,
    this.loadMore,
  }) : super(key: key);

  int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final ShimmerProperties? shimmerProperties;
  final bool? isLoading;
  final bool? enableShimmerLoading;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? enablePullDownRefresh;
  final PullDownRefreshOption? pullDownRefreshOption;
  final ValueGetter<List<T>>? loadMore;

  @override
  State<GSList<T>> createState() => _GSListState<T>();
}

class _GSListState<T> extends State<GSList<T>> {
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    widget.controller?.addListener(() {
      _onScroll();
    });
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
      child: (widget.isLoading ?? false)
          ? _LoadingWidget(
              scrollDirection: widget.scrollDirection,
              simpleLoading: widget.loadingWidget,
              enableShimmer: widget.enableShimmerLoading,
              shimmerProperties: widget.shimmerProperties,
            )
          : _ListWidget(
              itemBuilder: widget.itemBuilder,
              itemCount: widget.itemCount,
              controller: widget.controller,
              height: widget.height,
              pullDownRefreshOption: widget.pullDownRefreshOption,
              emptyWidget: widget.emptyWidget,
              loadingWidget: widget.loadingWidget,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              physics: widget.physics,
              scrollDirection: widget.scrollDirection,
              shrinkWrap: widget.shrinkWrap,
              enablePullDownRefresh: widget.enablePullDownRefresh ?? false,
              refreshController: refreshController,
            ),
    );
  }

  void refreshComplete() {
    refreshController.refreshCompleted();
  }

  bool _isBottom() {
    if (!widget.controller!.hasClients) return false;
    final maxScroll = widget.controller!.position.maxScrollExtent;
    final currentScroll = widget.controller!.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  _onScroll() {
    if (_isBottom()) {
      if ((widget.loadMore?.call().length ?? 0) != 0) {
        int count = widget.loadMore?.call().length ?? 0;
        setState(() {
          widget.itemCount = count;
        });
      }
    }
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    Key? key,
    required this.refreshController,
    required this.itemCount,
    this.controller,
    this.physics,
    this.scrollDirection,
    this.shrinkWrap,
    this.height,
    required this.itemBuilder,
    this.keyboardDismissBehavior,
    this.enablePullDownRefresh,
    this.pullDownRefreshOption,
    this.emptyWidget,
    this.loadingWidget,
  }) : super(key: key);

  final int itemCount;
  final ScrollController? controller;
  final bool? enablePullDownRefresh;
  final PullDownRefreshOption? pullDownRefreshOption;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
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
          pullDownRefreshOption?.onRefresh?.call(refreshController);
        },
        onLoading: () {
          pullDownRefreshOption?.onLoading?.call(refreshController);
        },
        child: ListView.builder(
          controller: controller,
          physics: physics,
          scrollDirection: scrollDirection ?? Axis.vertical,
          shrinkWrap: shrinkWrap ?? false,
          keyboardDismissBehavior: keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
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
