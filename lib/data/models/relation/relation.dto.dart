import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation.dto.freezed.dart';
part 'relation.dto.g.dart';

@freezed
class RelationDto with _$RelationDto {
  factory RelationDto({
    String? relation,
    List<GenericEntryDto>? entry,
  }) = _RelationDto;

  factory RelationDto.fromJson(Map<String, dynamic> json) => _$RelationDtoFromJson(json);
}
