import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.dto.freezed.dart';
part 'episode.dto.g.dart';

@freezed
class EpisodeDto with _$EpisodeDto {
  factory EpisodeDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? url,
    String? title,
    @JsonKey(name: 'title_japanese') String? titleJapanese,
    @JsonKey(name: 'title_romanji') String? titleRomanji,
    String? aired,
    double? score,
    bool? filler,
    bool? recap,
    @JsonKey(name: 'forum_url') String? forumUrl,
  }) = _EpisodeDto;

  factory EpisodeDto.fromJson(Map<String, dynamic> json) => _$EpisodeDtoFromJson(json);
}
