import 'package:freezed_annotation/freezed_annotation.dart';

part 'date.dto.freezed.dart';
part 'date.dto.g.dart';

@freezed
class DateDto with _$DateDto {
  factory DateDto({
    int? day,
    int? month,
    int? year,
  }) = _DateDto;

  factory DateDto.fromJson(Map<String, dynamic> json) =>
      _$DateDtoFromJson(json);
}
