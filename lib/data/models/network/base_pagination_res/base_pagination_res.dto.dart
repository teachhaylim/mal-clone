import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination.dto.dart';

part 'base_pagination_res.dto.freezed.dart';
part 'base_pagination_res.dto.g.dart';

@Freezed(genericArgumentFactories: true)
class BasePaginationResDto<T> with _$BasePaginationResDto<T> {
  factory BasePaginationResDto({
    required PaginationDto pagination,
    required List<T> data,
  }) = _BasePaginationResDto;

  factory BasePaginationResDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BasePaginationResDtoFromJson(json, fromJsonT);
}
