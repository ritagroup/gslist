import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gslist/gs_list/models/pull_down_refresh_option.dart';
import 'package:gslist/gs_list/models/shimmer_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class GSList extends StatelessWidget {
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
    this.enablePullDownRefresh, this.pullDownRefreshOption

  }) : super(key: key);

  final int itemCount;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? isLoading;
  final bool? enableShimmerLoading;
  final bool? enablePullDownRefresh;
  final ShimmerProperties? shimmerProperties;
  final PullDownRefreshOption? pullDownRefreshOption;
  RefreshController refreshController = RefreshController(initialRefresh: false);

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
      child: (isLoading ?? false)
          ? LoadingWidget(
        enableShimmer: enableShimmerLoading,
        shimmerProperties: shimmerProperties,
      )
          : ListWidget(
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        controller: controller,
        height: height,
        keyboardDismissBehavior: keyboardDismissBehavior,
        physics: physics,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        enablePullDownRefresh: enablePullDownRefresh ?? false,
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  ListWidget({
    Key? key,
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
  }) : super(key: key);

  final int itemCount;
  final bool? enablePullDownRefresh;
  final PullDownRefreshOption? pullDownRefreshOption;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final bool? shrinkWrap;
  final double? height;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SizedBox(height: height ?? double.infinity, child: Container());
    } else {
      return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh:pullDownRefreshOption?.onRefresh,
        onLoading:pullDownRefreshOption?.onLoading,

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

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.shimmerProperties, this.enableShimmer}) : super(key: key);
  final ShimmerProperties? shimmerProperties;

  final bool? enableShimmer;

  @override
  Widget build(BuildContext context) {
    if ((enableShimmer ?? false) && shimmerProperties != null) {} else {}
    return const Placeholder();
  }
}
