import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.dto.freezed.dart';
part 'theme.dto.g.dart';

@freezed
class ThemeDto with _$ThemeDto {
  factory ThemeDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? type,
    String? name,
    String? url,
  }) = _ThemeDto;

  factory ThemeDto.fromJson(Map<String, dynamic> json) =>
      _$ThemeDtoFromJson(json);
}
