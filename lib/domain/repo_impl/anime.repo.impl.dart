import 'package:dio/dio.dart';
import 'package:mal_clone/data/enums/sort_by.enum.dart';
import 'package:mal_clone/data/enums/rating.enum.dart';
import 'package:mal_clone/data/enums/order_by.enum.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/enums/airing_status.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/data/models/episode/episode.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/stats/stats.dto.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/data/models/theme_song/theme_song.dto.dart';
import 'package:mal_clone/domain/api/anime.api.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';

class AnimeRepoImpl extends AnimeRepo {
  final AnimeApi animeApi;

  AnimeRepoImpl({required this.animeApi});

  @override
  Future<ApiResponse<AnimeDto>> getAnimeById({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeById(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<AnimeDto>> getAnimeByIdFull({required int animeId}) {
    // TODO: implement getAnimeByIdFull
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> searchAnime({
    int? page = 1,
    int? limit = 10,
    String? searchText,
    FilterEnum? type,
    double? score,
    double? minScore,
    double? maxScore,
    AiringStatusEnum? airingStatus,
    RatingEnum? rating,
    bool? sfw,
    List<GenericEntryDto>? genres,
    List<GenericEntryDto>? genresExclude,
    OrderByEnum? orderBy,
    SortByEnum? sortBy,
    String? letter,
    List<String>? producers,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final res = await animeApi.searchAnime(
        page: page,
        searchText: searchText,
        type: type?.toApi,
        score: score,
        maxScore: maxScore,
        minScore: minScore,
        airingStatus: airingStatus?.toApi,
        rating: rating?.toApi,
        sfw: sfw,
        genres: genres?.map((e) => e.malId).toList().join(","),
        genresExclude: genresExclude?.map((e) => e.malId).toList().join(","),
        sortBy: sortBy?.toApi,
        orderBy: orderBy?.toApi,
        letter: letter,
        producers: producers?.map((e) => e).toString(),
        startDate: startDate,
        endDate: endDate,
      );
      return ApiSuccessResponse(data: res);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<List<StreamingServiceDto>>> getAnimeStreamingServices({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeStreamingServices(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<List<RelationDto>>> getAnimeRelations({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeRelations(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<List<CharacterDto>>> getAnimeCharacters({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeCharacters(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<BasePaginationResDto<EpisodeDto>>> getAnimeEpisodes({required int animeId, int? page = 1}) async {
    try {
      final res = await animeApi.getAnimeEpisodes(animeId: animeId.toString(), page: page);
      return ApiSuccessResponse(data: res);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<List<ImageDto>>> getAnimeImages({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeImages(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<ThemeSongDto>> getAnimeThemeSongs({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeThemeSongs(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }

  @override
  Future<ApiResponse<StatsDto>> getAnimeStatistics({required int animeId}) async {
    try {
      final res = await animeApi.getAnimeStatistics(animeId: animeId.toString());
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (error) {
      return ApiResponse.parseDioError(error: error);
    } catch (error) {
      return ApiErrorResponse(message: error.toString());
    }
  }
}
