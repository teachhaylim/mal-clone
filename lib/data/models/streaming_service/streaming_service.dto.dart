import 'package:freezed_annotation/freezed_annotation.dart';

part 'streaming_service.dto.freezed.dart';
part 'streaming_service.dto.g.dart';

@freezed
class StreamingServiceDto with _$StreamingServiceDto {
  factory StreamingServiceDto({
    String? name,
    String? url,
  }) = _StreamingServiceDto;

  factory StreamingServiceDto.fromJson(Map<String, dynamic> json) => _$StreamingServiceDtoFromJson(json);
}
