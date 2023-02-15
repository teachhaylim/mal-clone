import 'package:freezed_annotation/freezed_annotation.dart';

part 'broadcast.dto.freezed.dart';
part 'broadcast.dto.g.dart';

@freezed
class BroadcastDto with _$BroadcastDto {
  factory BroadcastDto({
    String? day,
    String? time,
    String? timezone,
    String? string,
  }) = _BroadcastDto;

  factory BroadcastDto.fromJson(Map<String, dynamic> json) =>
      _$BroadcastDtoFromJson(json);
}
