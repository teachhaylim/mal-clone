import 'package:flutter/material.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

class AnimeItemGrid extends StatefulWidget {
  const AnimeItemGrid({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  @override
  State<AnimeItemGrid> createState() => _AnimeItemGridState();
}

class _AnimeItemGridState extends State<AnimeItemGrid> {
  late final AnimeDto anime;

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
  }

  void _onAnimeTap(AnimeDto anime) {
    logger.i(anime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAnimeTap(anime),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(DesignSystem.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DesignSystem.radius8),
                child: CustomImageViewer(url: anime.images?.webp?.imageUrl),
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
    );
  }
}
