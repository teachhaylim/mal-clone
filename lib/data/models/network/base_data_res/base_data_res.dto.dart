import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_data_res.dto.freezed.dart';
part 'base_data_res.dto.g.dart';

@Freezed(genericArgumentFactories: true)
class BaseDataResDto<T> with _$BaseDataResDto<T> {
  factory BaseDataResDto({
    required T data,
  }) = _BaseDataResDto;

  factory BaseDataResDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseDataResDtoFromJson(json, fromJsonT);
}
