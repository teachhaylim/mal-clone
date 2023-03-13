import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/widget/custom_button.dart';
import 'package:mal_clone/core/widget/custom_loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Future<void> showPhotoViewer({required BuildContext context, required List<String> images, required int initialIndex}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height,
    ),
    builder: (context) => CustomPhotoViewer(
      images: images,
      initialIndex: initialIndex,
      onClose: () => Navigator.of(context).pop(),
    ),
  );
}

class CustomPhotoViewer extends StatefulWidget {
  CustomPhotoViewer({Key? key, required this.images, this.initialIndex = 0, required this.onClose}) : super(key: key);

  final List<String> images;
  final int initialIndex;
  final VoidCallback onClose;

  @override
  State<CustomPhotoViewer> createState() => _CustomPhotoViewerState();
}

class _CustomPhotoViewerState extends State<CustomPhotoViewer> {
  late final List<String> imageUrls;
  late final int initialIndex;
  late final PageController controller;
  late final VoidCallback onClose;
  final ValueNotifier currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    imageUrls = widget.images;
    initialIndex = widget.initialIndex;
    onClose = widget.onClose;
    controller = PageController(initialPage: initialIndex);
    currentIndex.value = initialIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    logger.i(MediaQueryData.fromWindow(window).padding.top);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onClose,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: imageUrls.length,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            onPageChanged: (index) => currentIndex.value = index + 1,
            loadingBuilder: (context, event) => Container(
              color: Colors.white,
              child: Center(
                child: CustomLoadingIndicator.loadingIndicator,
              ),
            ),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(imageUrls[index]),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes: PhotoViewHeroAttributes(tag: imageUrls[index]),
                minScale: 0.8,
                maxScale: 5.0,
              );
            },
          ),
          Positioned(
            top: MediaQueryData.fromWindow(window).padding.top,
            child: CustomButton.closeButton(
              onPressed: onClose,
              color: Colors.grey.shade300,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, value, widget) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: Text(
                    "$value / ${imageUrls.length}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
