

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullDownRefreshOption{
   ValueChanged<RefreshController>? onRefresh;
   ValueChanged<RefreshController>? onLoading;

   PullDownRefreshOption({this.onRefresh, this.onLoading});
}