import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });
  const ShimmerWidget.rectangular({required this.width, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        // period: Duration(seconds: 3),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.white60,
            shape: shapeBorder,
          ),
        ),
      );
}
