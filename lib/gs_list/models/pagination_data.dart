import 'package:flutter/cupertino.dart';

class PaginationData<T> {
  int totalCount;

  int isLoading;

  int currentPage;

  ValueGetter<List<T>> loadMore;

  PaginationData({
   required this.totalCount,
    required this.isLoading,
    required this.currentPage,
    required this.loadMore,
  });
}
