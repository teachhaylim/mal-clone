import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/navigation/routes.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

class ListItemHorizontal extends StatelessWidget {
  const ListItemHorizontal({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  void _onAnimeTap(AnimeDto anime) => Get.toNamed(AppRoutes.animeDetailScreen, arguments: anime.malId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAnimeTap(anime),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  child: CustomImageViewer(url: anime.images?.webp?.largeImageUrl),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    anime.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
