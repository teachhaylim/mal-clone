import 'package:freezed_annotation/freezed_annotation.dart';

part 'images.dto.freezed.dart';
part 'images.dto.g.dart';

@freezed
class ImagesDto with _$ImagesDto {
  factory ImagesDto({
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'small_image_url') String? smallImageUrl,
    @JsonKey(name: 'medium_image_url') String? mediumImageUrl,
    @JsonKey(name: 'large_image_url') String? largeImageUrl,
    @JsonKey(name: 'maximum_image_url') String? maximumImageUrl,
  }) = _ImagesDto;

  factory ImagesDto.fromJson(Map<String, dynamic> json) => _$ImagesDtoFromJson(json);
}
