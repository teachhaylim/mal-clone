import 'package:freezed_annotation/freezed_annotation.dart';

part 'title.dto.freezed.dart';
part 'title.dto.g.dart';

@freezed
class TitleDto with _$TitleDto {
  factory TitleDto({
    String? type,
    String? title,
  }) = _TitleDto;

  factory TitleDto.fromJson(Map<String, dynamic> json) =>
      _$TitleDtoFromJson(json);
}
