import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';

part 'sub_character.dto.freezed.dart';
part 'sub_character.dto.g.dart';

@freezed
class SubCharacterDto with _$SubCharacterDto {
  factory SubCharacterDto({
    @JsonKey(name: 'mal_id') int? malId,
    String? url,
    String? name,
    ImageDto? images,
  }) = _SubCharacterDto;

  factory SubCharacterDto.fromJson(Map<String, dynamic> json) => _$SubCharacterDtoFromJson(json);
}
