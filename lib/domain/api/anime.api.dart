import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_data_res/base_data_res.dto.dart';
import 'package:retrofit/http.dart';

part "anime.api.g.dart";

@RestApi()
abstract class AnimeApi {
  factory AnimeApi({required Dio dio}) {
    return _AnimeApi(dio);
  }

  @GET("anime/{id}")
  Future<BaseDataResDto<AnimeDto>> getAnimeById({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/full")
  Future<BaseDataResDto<AnimeDto>> getAnimeByIdFull({
    @Path("id") required String animeId,
  });
}
