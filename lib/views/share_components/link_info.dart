import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/custom_url_launcher.dart';

class AnimeLinkInfo extends StatelessWidget {
  const AnimeLinkInfo({super.key, required this.anime});

  final AnimeDto anime;

  void _onTrailerClick() {
    CustomUrlLauncher.launch(url: anime.trailer?.url);
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
            AppLocale.linkText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          TextButton.icon(
            onPressed: _onTrailerClick,
            icon: const Icon(Icons.movie_creation_rounded),
            label: const Text("Trailer"),
          ),
        ],
      ),
    );
  }
}
