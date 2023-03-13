import 'package:flutter/material.dart';
import 'package:mal_clone/data/models/song/song.dto.dart';
import 'package:mal_clone/utils/custom_url_launcher.dart';
import 'package:mal_clone/utils/function.dart';

class ThemeSongItem extends StatelessWidget {
  const ThemeSongItem({super.key, required this.song});

  final SongDto song;

  void _onTap() => CustomUrlLauncher.launch(url: song.toYouTubeSearch);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      dense: true,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      style: ListTileStyle.drawer,
      title: Text(toDisplayText(song.title)),
      subtitle: Text(toDisplayText(song.artist)),
      trailing: Text(toDisplayText(song.between), style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11)),
    );
  }
}
