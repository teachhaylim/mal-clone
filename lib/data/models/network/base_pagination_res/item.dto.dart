import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.dto.freezed.dart';
part 'item.dto.g.dart';

@freezed
class ItemDto with _$ItemDto {
  factory ItemDto({
    int? count,
    int? total,
    @JsonKey(name: 'per_page') int? perPage,
  }) = _ItemDto;

  factory ItemDto.fromJson(Map<String, dynamic> json) => _$ItemDtoFromJson(json);
}
