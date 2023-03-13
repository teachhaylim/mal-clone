import 'package:flutter/material.dart';

extension ScrollControllerExt on ScrollController {
  bool get isBottom {
    if (!hasClients) return false;

    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;

    return currentScroll >= maxScroll;
  }
}
