import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/person/person.dto.dart';
import 'package:mal_clone/data/models/sub_character/sub_character.dto.dart';

part 'character.dto.freezed.dart';
part 'character.dto.g.dart';

@freezed
class CharacterDto with _$CharacterDto {
  factory CharacterDto({
    SubCharacterDto? character,
    String? role,
    int? favorites,
    @JsonKey(name: 'voice_actors') List<PersonDto>? voiceActors,
  }) = _CharacterDto;

  factory CharacterDto.fromJson(Map<String, dynamic> json) => _$CharacterDtoFromJson(json);
}
