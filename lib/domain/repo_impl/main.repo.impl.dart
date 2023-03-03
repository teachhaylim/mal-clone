import 'package:dio/dio.dart';
import 'package:mal_clone/core/config/preference_key.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/airing_status.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/domain/api/main.api.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';
import 'package:mal_clone/utils/function.dart';

class MainRepoImpl extends MainRepo {
  final MainApi mainApi;

  MainRepoImpl({required this.mainApi});

  @override
  Future<ApiResponse<List<GenericEntryDto>>> getAnimeGenres() async {
    try {
      final localDB = getBox().get(AppPreference.genresKey);
      if (localDB != null) return ApiSuccessResponse(data: localDB.cast<GenericEntryDto>());

      final res = await mainApi.getAnimeGenres();
      final sortedData = [...res.data]..sort((a, b) => a.name?.compareTo(b.name ?? "") ?? -1);
      getBox().put(AppPreference.genresKey, sortedData);
      return ApiSuccessResponse(data: sortedData);
    } on DioError catch (e) {
      return ApiResponse.parseDioError(error: e);
    } catch (e) {
      return ApiErrorResponse(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getTopAnime({int page = 1, int limit = 20, FilterEnum? filter, AiringStatusEnum? type}) async {
    try {
      final res = await mainApi.getTopAnime(page: page, limit: limit, filter: type?.name, type: filter?.name);
      return ApiSuccessResponse(data: res);
    } on DioError catch (e) {
      return ApiResponse.parseDioError(error: e);
    } catch (e) {
      return ApiErrorResponse(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getAnimeByAiringSchedule({int page = 1, int limit = 20, required String day, bool sfw = true, bool kids = false}) async {
    try {
      final res = await mainApi.getAnimeByAiringSchedule(page: page, limit: limit, filter: day, sfw: sfw, kids: kids);
      return ApiSuccessResponse(data: res);
    } on DioError catch (e) {
      return ApiResponse.parseDioError(error: e);
    } catch (e) {
      return ApiErrorResponse(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<AnimeDto>> getRandomAnime() async {
    try {
      final res = await mainApi.getRandomAnime();
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (e) {
      return ApiResponse.parseDioError(error: e);
    } catch (e) {
      return ApiErrorResponse(message: e.toString());
    }
  }
}
