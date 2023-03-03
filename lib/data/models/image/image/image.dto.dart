import 'package:mal_clone/data/models/image_format/jpg/jpg.dto.dart';
import 'package:mal_clone/data/models/image_format/webp/webp.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.dto.freezed.dart';
part 'image.dto.g.dart';

@freezed
class ImageDto with _$ImageDto {
  factory ImageDto({
    JpgDto? jpg,
    WebpDto? webp,
  }) = _ImageDto;

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);
}
