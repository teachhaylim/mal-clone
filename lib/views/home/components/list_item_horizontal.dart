import 'package:flutter/material.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

class ListItemHorizontal extends StatelessWidget {
  const ListItemHorizontal({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  void _onAnimeTap(AnimeDto anime) {
    logger.i(anime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAnimeTap(anime),
      child: Container(
        width: 170,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: CustomImageViewer(url: anime.images?.webp?.imageUrl),
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
    );
  }
}
