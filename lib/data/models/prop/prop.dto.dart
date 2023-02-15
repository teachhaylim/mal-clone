import 'package:mal_clone/data/models/date/date.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prop.dto.freezed.dart';
part 'prop.dto.g.dart';

@freezed
class PropDto with _$PropDto {
  factory PropDto({
    DateDto? from,
    DateDto? to,
  }) = _PropDto;

  factory PropDto.fromJson(Map<String, dynamic> json) => _$PropDtoFromJson(json);
}
