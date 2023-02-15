import 'package:dio/dio.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/domain/api/season.api.dart';
import 'package:mal_clone/domain/repo/season.repo.dart';

class SeasonRepoImpl extends SeasonRepo {
  final SeasonApi seasonApi;
  SeasonRepoImpl({required this.seasonApi});

  @override
  Future<ApiResponse<List<AnimeDto>>> getSeason() async {
    try {
      final res = await seasonApi.getSeason();
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getCurrentSeason({int? page = 1}) async {
    try {
      final res = await seasonApi.getCurrentSeason(page: page);
      return ApiSuccessResponse(data: res);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getSeasonByYearNSeason({required String year, required SeasonEnum season, int? page = 1, FilterEnum? filter}) async {
    try {
      final res = await seasonApi.getSeasonByYearNSeason(year: year, season: season.name, page: page, filter: filter?.name);
      return ApiSuccessResponse(data: res);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getUpcomingSeason({int? page = 1, FilterEnum? filter}) async {
    try {
      final res = await seasonApi.getUpcomingSeason(page: page, filter: filter?.name);
      return ApiSuccessResponse(data: res);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }
}
