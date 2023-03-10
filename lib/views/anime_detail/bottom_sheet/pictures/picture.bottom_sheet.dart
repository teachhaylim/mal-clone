import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_photo_viewer.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

Future<void> showPictureSheet({required BuildContext context, required AnimeDto anime}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => PicturesContent(
      anime: anime,
    ),
  );
}

class PicturesContent extends StatefulWidget {
  PicturesContent({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  @override
  State<PicturesContent> createState() => _PicturesContentState();
}

class _PicturesContentState extends State<PicturesContent> {
  late final AnimeDto anime;
  final int crossAxisCount = 3;
  final List<String> images = [
    "https://cdn.myanimelist.net/images/anime/1/20l.jpg",
    "https://cdn.myanimelist.net/images/anime/7/4289l.jpg",
    "https://cdn.myanimelist.net/images/anime/7/4641l.jpg",
    "https://cdn.myanimelist.net/images/anime/4/4644l.jpg",
    "https://cdn.myanimelist.net/images/anime/13/17405l.jpg",
    "https://cdn.myanimelist.net/images/anime/6/23162l.jpg",
    "https://cdn.myanimelist.net/images/anime/1359/111463l.jpg",
    "https://cdn.myanimelist.net/images/anime/1813/119179l.jpg",
    "https://cdn.myanimelist.net/images/anime/1115/132764l.jpg",
  ];

  List<Widget> get generateRandomTiles {
    final length = images.length;
    Random random = Random();
    List<StaggeredGridTile> _staggeredTiles = [];

    for (int index = 0; index < length; index++) {
      String image = images[index];
      num mainAxisCellCount = 0;
      double temp = random.nextDouble();

      if (temp > 0.6) {
        mainAxisCellCount = temp + 0.5;
      } else if (temp < 0.3) {
        mainAxisCellCount = temp + 0.9;
      } else {
        mainAxisCellCount = temp + 0.7;
      }

      _staggeredTiles.add(StaggeredGridTile.count(
        crossAxisCellCount: random.nextInt(1) + 1,
        mainAxisCellCount: mainAxisCellCount,
        child: SizedBox(
          height: double.infinity,
          child: GestureDetector(
            onTap: () => _onViewImages(initialIndex: index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DesignSystem.radius8),
              child: CustomImageViewer(url: image),
            ),
          ),
        ),
      ));
    }

    return _staggeredTiles;
  }

  void _onViewImages({int initialIndex = 0}) {
    showPhotoViewer(
      images: images,
      initialIndex: initialIndex,
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocale.pictures,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: DesignSystem.spacing8),
            StaggeredGrid.count(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: images.length.toDouble(),
              crossAxisSpacing: DesignSystem.spacing8,
              children: generateRandomTiles,
            ),
            const SizedBox(height: DesignSystem.spacing16),
          ],
        ),
      ),
    );
  }
}
