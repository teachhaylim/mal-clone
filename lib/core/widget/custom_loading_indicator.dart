import 'package:flutter/material.dart';

class CustomLoadingIndicator {
  static Widget get loadingIndicator {
    return const CircularProgressIndicator.adaptive();
  }

  static Widget get fullScreenIndicator {
    //TODO: adjust to fit full screen
    return const CircularProgressIndicator.adaptive();
  }
}
