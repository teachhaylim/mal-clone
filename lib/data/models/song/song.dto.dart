import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/core/config/constant.dart';

part 'song.dto.freezed.dart';
part 'song.dto.g.dart';

@freezed
class SongDto with _$SongDto {
  SongDto._();

  factory SongDto({
    String? title,
    String? artist,
    String? between,
  }) = _SongDto;

  String get toYouTubeSearch {
    return AppConstant.youtubeSearch(searchQuery: "$title by $artist");
  }

  factory SongDto.fromJson(Map<String, dynamic> json) => _$SongDtoFromJson(json);
}
