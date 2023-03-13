import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.dto.freezed.dart';
part 'score.dto.g.dart';

@freezed
class ScoreDto with _$ScoreDto {
  factory ScoreDto({
    int? score,
    int? votes,
    double? percentage,
  }) = _ScoreDto;

  factory ScoreDto.fromJson(Map<String, dynamic> json) => _$ScoreDtoFromJson(json);
}
