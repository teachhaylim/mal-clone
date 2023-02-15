import 'package:freezed_annotation/freezed_annotation.dart';

part 'jpg.dto.freezed.dart';
part 'jpg.dto.g.dart';

@freezed
class JpgDto with _$JpgDto {
  factory JpgDto({
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'small_image_url') String? smallImageUrl,
    @JsonKey(name: 'large_image_url') String? largeImageUrl,
  }) = _JpgDto;

  factory JpgDto.fromJson(Map<String, dynamic> json) => _$JpgDtoFromJson(json);
}
