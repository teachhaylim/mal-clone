import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mal_clone/data/enums/airing_status.enum.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/enums/order_by.enum.dart';
import 'package:mal_clone/data/enums/rating.enum.dart';
import 'package:mal_clone/data/enums/sort_by.enum.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';

part 'args.helper.freezed.dart';

@freezed
class ArgsHelper with _$ArgsHelper {
  ArgsHelper._();

  factory ArgsHelper({
    String? searchText,
    FilterEnum? type,
    double? score,
    double? minScore,
    double? maxScore,
    AiringStatusEnum? airingStatus,
    RatingEnum? rating,
    bool? sfw,
    List<GenericEntryDto>? genres,
    List<GenericEntryDto>? genreExcludes,
    OrderByEnum? orderBy,
    SortByEnum? sortBy,
    String? letter,
    List<String>? producers,
    String? startDate,
    String? endDate,
  }) = _ArgsHelper;

  bool get isFiltered {
    return searchText != null || type != null || score != null || minScore != null || maxScore != null || airingStatus != null || rating != null || sfw != null || genres != null || genreExcludes != null || orderBy != null || sortBy != null || letter != null || producers != null || startDate != null || endDate != null;
  }
}
