import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generic_entry.dto.freezed.dart';
part 'generic_entry.dto.g.dart';

@freezed
@HiveType(typeId: 1)
class GenericEntryDto with _$GenericEntryDto {
  factory GenericEntryDto({
    @HiveField(0) @JsonKey(name: 'mal_id') int? malId,
    @HiveField(1) String? type,
    @HiveField(2) String? name,
    @HiveField(3) String? url,
  }) = _GenericEntryDto;

  factory GenericEntryDto.fromJson(Map<String, dynamic> json) => _$GenericEntryDtoFromJson(json);
}
