import 'package:flutter/material.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/share_components/star_rating.dart';

class AnimeHeaderInfo extends StatelessWidget {
  const AnimeHeaderInfo({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: DesignSystem.spacing16),
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignSystem.radius8),
      ),
      child: Column(
        children: [
          Text(
            toDisplayText(anime.titleEnglish),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: DesignSystem.spacing4),
          Text(
            toDisplayText(anime.titleJapanese),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: DesignSystem.spacing8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                label: Text(toDisplayText(anime.type)),
              ),
              const SizedBox(width: DesignSystem.spacing8),
              Chip(
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                label: Text(toDisplayText(anime.source)),
              ),
              const SizedBox(width: DesignSystem.spacing8),
              Chip(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                label: StarRating(
                  ratingValue: anime.score,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
