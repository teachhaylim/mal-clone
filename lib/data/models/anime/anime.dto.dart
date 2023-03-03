import 'package:mal_clone/data/models/aired/aired.dto.dart';
import 'package:mal_clone/data/models/broadcast/broadcast.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/theme/theme.dto.dart';
import 'package:mal_clone/data/models/title/title.dto.dart';
import 'package:mal_clone/data/models/trailer/trailer.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime.dto.freezed.dart';
part 'anime.dto.g.dart';

@freezed
class AnimeDto with _$AnimeDto {
  factory AnimeDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? url,
    ImageDto? images,
    TrailerDto? trailer,
    bool? approved,
    List<TitleDto>? titles,
    String? title,
    @JsonKey(name: 'title_english') String? titleEnglish,
    @JsonKey(name: 'title_japanese') String? titleJapanese,
    @JsonKey(name: 'title_synonyms') List<dynamic>? titleSynonyms,
    String? type,
    String? source,
    int? episodes,
    String? status,
    bool? airing,
    AiredDto? aired,
    String? duration,
    String? rating,
    double? score,
    @JsonKey(name: 'scored_by') int? scoredBy,
    int? rank,
    int? popularity,
    int? members,
    int? favorites,
    String? synopsis,
    String? background,
    String? season,
    int? year,
    BroadcastDto? broadcast,
    List<GenericEntryDto>? producers,
    List<GenericEntryDto>? licensors,
    List<GenericEntryDto>? studios,
    List<GenericEntryDto>? genres,
    @JsonKey(name: 'explicit_genres') List<GenericEntryDto>? explicitGenres,
    List<ThemeDto>? themes,
    List<GenericEntryDto>? demographics,
    List<RelationDto>? relations,
    ThemeDto? theme,
    List<GenericEntryDto>? external,
    List<GenericEntryDto>? streaming,
  }) = _AnimeDto;

  factory AnimeDto.fromJson(Map<String, dynamic> json) => _$AnimeDtoFromJson(json);
}
