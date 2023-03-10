import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/random/components/row_item.dart';

class AnimeBroadcastInfo extends StatelessWidget {
  const AnimeBroadcastInfo({super.key, required this.anime});

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
            AppLocale.broadcastInfoText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          RowItem(title: AppLocale.statusText, value: anime.status),
          RowItem(title: AppLocale.ratingText, value: anime.rating),
          RowItem(title: AppLocale.episodesText, value: anime.episodes),
          RowItem(title: AppLocale.durationText, value: anime.duration),
          RowItem(title: AppLocale.premieredOnText, value: "${toDisplayText(SeasonEnum.parseSeason(anime.season)?.toDisplayText)} (${toDisplayText(anime.year)})"),
          RowItem(title: AppLocale.broadcastPeriodText, value: anime.aired?.string),
          RowItem(title: AppLocale.broadcastDayText, value: anime.broadcast?.string),
        ],
      ),
    );
  }
}
