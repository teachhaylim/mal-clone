import 'package:mal_clone/data/models/network/base_pagination_res/item.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.dto.freezed.dart';
part 'pagination.dto.g.dart';

@freezed
class PaginationDto with _$PaginationDto {
  factory PaginationDto({
    @JsonKey(name: 'last_visible_page') int? lastVisiblePage,
    @JsonKey(name: 'has_next_page') bool? hasNextPage,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'items') ItemDto? item,
  }) = _PaginationDto;

  factory PaginationDto.fromJson(Map<String, dynamic> json) => _$PaginationDtoFromJson(json);
}
