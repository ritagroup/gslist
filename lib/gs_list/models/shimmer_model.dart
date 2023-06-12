
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProperties {
  Color baseColor;

  Color highlightColor;

  Widget child;

  ShimmerDirection? direction;

  bool? enable;

  Duration? period;

  ShimmerProperties({
    required this.baseColor,
    required this.highlightColor,
    required this.child,
    this.direction,
    this.enable,
    this.period,
  });
}
