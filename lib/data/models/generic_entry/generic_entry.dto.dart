import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_entry.dto.freezed.dart';
part 'generic_entry.dto.g.dart';

@freezed
class GenericEntryDto with _$GenericEntryDto {
  factory GenericEntryDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? type,
    String? name,
    String? url,
  }) = _GenericEntryDto;

  factory GenericEntryDto.fromJson(Map<String, dynamic> json) => _$GenericEntryDtoFromJson(json);
}
