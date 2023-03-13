import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_photo_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/bloc/common.bottom_sheet.bloc.dart';

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
  late final CommonBottomSheetBloc commonBottomSheetBloc;

  List<Widget> generateRandomTiles(List<ImageDto> images) {
    final length = images.length;
    Random random = Random();
    List<StaggeredGridTile> _staggeredTiles = [];

    for (int index = 0; index < length; index++) {
      ImageDto image = images[index];
      num mainAxisCellCount = 0;
      double temp = random.nextDouble();

      if (temp > 0.6) {
        mainAxisCellCount = temp + 0.6;
      } else if (temp < 0.3) {
        mainAxisCellCount = temp + 1.0;
      } else {
        mainAxisCellCount = temp + 0.8;
      }

      _staggeredTiles.add(StaggeredGridTile.count(
        crossAxisCellCount: random.nextInt(1) + 1,
        mainAxisCellCount: mainAxisCellCount,
        child: SizedBox(
          height: double.infinity,
          child: GestureDetector(
            onTap: () => _onViewImages(images: images, initialIndex: index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DesignSystem.radius8),
              child: CustomImageViewer(url: image.jpg?.largeImageUrl),
            ),
          ),
        ),
      ));
    }

    return _staggeredTiles;
  }

  void _onViewImages({required List<ImageDto> images, int initialIndex = 0}) {
    showPhotoViewer(
      images: images.map((e) => e.jpg?.largeImageUrl).whereNotNull().toList(),
      initialIndex: initialIndex,
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
    commonBottomSheetBloc = CommonBottomSheetBloc(animeId: anime.malId ?? -1)..add(const CommonBottomSheetGetPictureEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => commonBottomSheetBloc,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
        child: BlocConsumer<CommonBottomSheetBloc, CommonBottomSheetState>(
          listener: (context, state) {
            if (state is CommonBottomSheetErrorState) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error.message,
              );
            }
          },
          builder: (context, state) {
            if (state is CommonBottomSheetLoadingState) {
              return CustomSkeletonLoading.boxSkeleton(rounded: DesignSystem.radius8);
            }

            if (state is CommonBottomSheetPictureLoadedState) {
              final images = state.images;

              if (images.isEmpty) {
                return Center(
                  child: Text(AppLocale.noInfoAvailable),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaggeredGrid.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: images.length.toDouble(),
                      crossAxisSpacing: DesignSystem.spacing8,
                      children: generateRandomTiles(images),
                    ),
                    const SizedBox(height: DesignSystem.spacing16),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
