import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/custom_url_launcher.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/episodes/episodes.bottom_sheet.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/pictures/picture.bottom_sheet.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/stats_rating/stats_rating.bottom_sheet.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/theme_songs/theme_songs.bottom_sheet.dart';

class AnimeDetailExtraInfoSection extends StatelessWidget {
  const AnimeDetailExtraInfoSection({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  void _onViewTrailerTap() {
    CustomUrlLauncher.launch(url: anime.trailer?.url);
  }

  void _onViewEpisodes(BuildContext context) {
    showEpisodesSheet(context: context, anime: anime);
  }

  void _onViewPicture(BuildContext context) {
    showPictureSheet(context: context, anime: anime);
  }

  void _onViewStats(BuildContext context) {
    showStatsRatingSheet(context: context, anime: anime);
  }

  void _onViewThemeSongs(BuildContext context) {
    showThemeSongsSheet(context: context, anime: anime);
  }

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
            AppLocale.extraInfoText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: DesignSystem.spacing4),
          ListTile(
            onTap: () => _onViewEpisodes(context),
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            style: ListTileStyle.list,
            leading: Icon(Icons.tv_outlined),
            title: Text(AppLocale.viewEpisodesText),
          ),
          ListTile(
            onTap: _onViewTrailerTap,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            style: ListTileStyle.list,
            leading: Icon(Icons.movie_outlined),
            title: Text(AppLocale.viewTrailerText),
          ),
          ListTile(
            onTap: () => _onViewPicture(context),
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            style: ListTileStyle.list,
            leading: Icon(Icons.photo_library_outlined),
            title: Text(AppLocale.viewPicturesText),
          ),
          ListTile(
            onTap: () => _onViewStats(context),
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            style: ListTileStyle.list,
            leading: Icon(Icons.insert_chart_outlined_rounded),
            title: Text(AppLocale.viewStatsRatingText),
          ),
          ListTile(
            onTap: () => _onViewThemeSongs(context),
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            style: ListTileStyle.list,
            leading: Icon(Icons.music_note_outlined),
            title: Text(AppLocale.viewThemeSongsText),
          ),
        ],
      ),
    );
  }
}
