import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/extensions/number.ext.dart';
import 'package:mal_clone/utils/function.dart';

class AnimeStatsInfo extends StatelessWidget {
  const AnimeStatsInfo({super.key, required this.anime});

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
            AppLocale.statsInfoText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.supervisor_account_rounded),
                      const Text(AppLocale.membersText),
                      Text(toDisplayText(anime.members?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.heart_broken_rounded),
                      const Text(AppLocale.favoritesText),
                      Text(toDisplayText(anime.favorites?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded),
                      const Text(AppLocale.popularityText),
                      Text(toDisplayText(anime.popularity?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.insert_chart_outlined_rounded),
                      const Text(AppLocale.rankingText),
                      Text(toDisplayText(anime.rank?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
