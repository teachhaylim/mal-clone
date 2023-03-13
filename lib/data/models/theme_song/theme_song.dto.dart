import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/song/song.dto.dart';

part 'theme_song.dto.freezed.dart';
part 'theme_song.dto.g.dart';

@freezed
class ThemeSongDto with _$ThemeSongDto {
  ThemeSongDto._();

  factory ThemeSongDto({
    List<String>? openings,
    List<String>? endings,
  }) = _ThemeSongDto;

  List<SongDto> get toOpeningSongs {
    return (openings ?? []).mapIndexed((index, value) => toSongDto(index, value)).toList();
  }

  List<SongDto> get toEndingSongs {
    return (endings ?? []).mapIndexed((index, value) => toSongDto(index, value)).toList();
  }

  SongDto toSongDto(int index, String value) {
    final cleanedValue = value.replaceAll('"', "").replaceAll("${index + 1}:", "").trim();
    final title = cleanedValue.substring(0, cleanedValue.indexOf("by"));
    final artist = cleanedValue.substring(cleanedValue.indexOf("by") + 3, cleanedValue.indexOf("(eps"));
    final between = cleanedValue.substring(cleanedValue.indexOf("(eps"));

    return SongDto(title: title, artist: artist, between: between);
  }

  factory ThemeSongDto.fromJson(Map<String, dynamic> json) => _$ThemeSongDtoFromJson(json);
}
