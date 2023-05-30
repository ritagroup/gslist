

import 'package:flutter/animation.dart';

class PullDownRefreshOption{
   VoidCallback? onRefresh;
   VoidCallback? onLoading;

   PullDownRefreshOption({this.onRefresh, this.onLoading});
}