import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';

abstract class SeasonRepo {
  Future<ApiResponse<List<AnimeDto>>> getSeason();
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getSeasonByYearNSeason({required String year, required SeasonEnum season, int? page = 1, FilterEnum? filter});
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getCurrentSeason({int? page = 1});
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getUpcomingSeason({int? page = 1, FilterEnum? filter});
}
