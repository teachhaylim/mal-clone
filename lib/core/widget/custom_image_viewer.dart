import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mal_clone/core/config/constant.dart';

class CustomImageViewer extends StatefulWidget {
  const CustomImageViewer({Key? key, this.url, this.fit = BoxFit.cover, this.height = double.infinity, this.width = double.infinity}) : super(key: key);

  final String? url;
  final BoxFit fit;
  final double width;
  final double height;

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  late final String? url;
  late final BoxFit fit;
  late final double width;
  late final double height;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    fit = widget.fit;
    width = widget.width;
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? AppConstant.placeholderImageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, extra) => const Center(
        child: Icon(Icons.error_outline_rounded),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
    );
  }
}
