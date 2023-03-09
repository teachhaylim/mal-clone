import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';

part 'sub_person.dto.freezed.dart';
part 'sub_person.dto.g.dart';

@freezed
class SubPersonDto with _$SubPersonDto {
  factory SubPersonDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? url,
    String? name,
    ImageDto? images,
  }) = _SubPersonDto;

  factory SubPersonDto.fromJson(Map<String, dynamic> json) => _$SubPersonDtoFromJson(json);
}
