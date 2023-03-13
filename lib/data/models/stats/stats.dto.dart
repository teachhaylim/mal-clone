import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/score/score.dto.dart';

part 'stats.dto.freezed.dart';
part 'stats.dto.g.dart';

@freezed
class StatsDto with _$StatsDto {
  factory StatsDto({
    int? watching,
    int? completed,
    @JsonKey(name: 'on_hold') int? onHold,
    int? dropped,
    @JsonKey(name: 'plan_to_watch') int? planToWatch,
    int? total,
    List<ScoreDto>? scores,
  }) = _StatsDto;

  factory StatsDto.fromJson(Map<String, dynamic> json) => _$StatsDtoFromJson(json);
}
