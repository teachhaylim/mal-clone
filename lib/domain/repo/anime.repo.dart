import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';

abstract class AnimeRepo {
  Future<ApiResponse<AnimeDto>> getAnimeById({required int animeId});
  Future<ApiResponse<AnimeDto>> getAnimeByIdFull({required int animeId});
}
