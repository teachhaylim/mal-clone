import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/core/network/api_response.dart';
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
}
