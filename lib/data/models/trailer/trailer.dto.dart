import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/models/image/images_dto/images.dto.dart';

part 'trailer.dto.freezed.dart';
part 'trailer.dto.g.dart';

@freezed
class TrailerDto with _$TrailerDto {
  factory TrailerDto({
    @JsonKey(name: 'youtube_id') String? youtubeId,
    String? url,
    @JsonKey(name: 'embed_url') String? embedUrl,
    ImagesDto? images,
  }) = _TrailerDto;

  factory TrailerDto.fromJson(Map<String, dynamic> json) => _$TrailerDtoFromJson(json);
}
