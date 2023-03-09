import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/sub_person/sub_person.dto.dart';

part 'person.dto.freezed.dart';
part 'person.dto.g.dart';

@freezed
class PersonDto with _$PersonDto {
  factory PersonDto({
    SubPersonDto? person,
    String? language,
  }) = _PersonDto;

  factory PersonDto.fromJson(Map<String, dynamic> json) => _$PersonDtoFromJson(json);
}
