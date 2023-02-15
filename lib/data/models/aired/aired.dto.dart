import 'package:mal_clone/data/models/prop/prop.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'aired.dto.freezed.dart';
part 'aired.dto.g.dart';

@freezed
class AiredDto with _$AiredDto {
  factory AiredDto({
    String? from,
    String? to,
    PropDto? prop,
    String? string,
  }) = _AiredDto;

  factory AiredDto.fromJson(Map<String, dynamic> json) => _$AiredDtoFromJson(json);
}
