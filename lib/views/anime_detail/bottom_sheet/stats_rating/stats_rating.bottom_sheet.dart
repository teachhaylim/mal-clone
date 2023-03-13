import 'package:flutter/material.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

Future<void> showStatsRatingSheet({required BuildContext context, required AnimeDto anime}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const SizedBox.shrink(),
  );
}
