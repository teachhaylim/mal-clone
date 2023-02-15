import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_data_list_res.dto.freezed.dart';
part 'base_data_list_res.dto.g.dart';

@Freezed(genericArgumentFactories: true)
class BaseDataListResDto<T> with _$BaseDataListResDto<T> {
  factory BaseDataListResDto({
    required List<T> data,
  }) = _BaseDataListResDto;

  factory BaseDataListResDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseDataListResDtoFromJson(json, fromJsonT);
}
