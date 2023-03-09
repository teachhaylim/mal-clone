import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomSkeletonLoading {
  static Widget boxSkeleton({
    double paddingLeft = 0,
    double paddingRight = 0,
    double paddingTop = 0,
    double paddingBottom = 0,
    double rounded = 0,
    double height = double.infinity,
    double width = double.infinity,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.fromLTRB(paddingLeft, paddingTop, paddingRight, paddingBottom),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(rounded),
        child: Shimmer.fromColors(
          baseColor: Get.isDarkMode ? Colors.black45 : Colors.grey.shade100,
          highlightColor: Get.isDarkMode ? Colors.grey.shade800.withOpacity(0.2) : Colors.grey.shade300,
          child: Container(color: Colors.black),
        ),
      ),
    );
  }
}
