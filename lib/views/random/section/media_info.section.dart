import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/views/random/components/row_items.dart';

class RandomMediaInfoSection extends StatelessWidget {
  const RandomMediaInfoSection({super.key, required this.anime});

  final AnimeDto anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      padding: const EdgeInsets.all(DesignSystem.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(DesignSystem.spacing16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.mediaText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          RowItems(
            title: AppLocale.genresText,
            value: anime.genres?.map((e) => e.name ?? "").toList() ?? [],
          ),
          RowItems(
            title: AppLocale.explictGenresText,
            value: anime.explicitGenres?.map((e) => e.name ?? "").toList() ?? [],
          ),
          RowItems(
            title: AppLocale.producersText,
            value: anime.producers?.map((e) => e.name ?? "").toList() ?? [],
          ),
          RowItems(
            title: AppLocale.licensorsText,
            value: anime.licensors?.map((e) => e.name ?? "").toList() ?? [],
          ),
          RowItems(
            title: AppLocale.themesText,
            value: anime.themes?.map((e) => e.name ?? "").toList() ?? [],
          ),
          RowItems(
            title: AppLocale.demographicsText,
            value: anime.demographics?.map((e) => e.name ?? "").toList() ?? [],
          ),
        ],
      ),
    );
  }
}
