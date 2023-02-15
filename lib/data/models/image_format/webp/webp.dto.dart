import 'package:freezed_annotation/freezed_annotation.dart';

part 'webp.dto.freezed.dart';
part 'webp.dto.g.dart';

@freezed
class WebpDto with _$WebpDto {
  factory WebpDto({
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'small_image_url') String? smallImageUrl,
    @JsonKey(name: 'large_image_url') String? largeImageUrl,
  }) = _WebpDto;

  factory WebpDto.fromJson(Map<String, dynamic> json) =>
      _$WebpDtoFromJson(json);
}
