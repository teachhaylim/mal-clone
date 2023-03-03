import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/network/base_data_list_res/base_data_list_res.dto.dart';
import 'package:mal_clone/data/models/network/base_data_res/base_data_res.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:retrofit/retrofit.dart';

part "main.api.g.dart";

@RestApi()
abstract class MainApi {
  factory MainApi({required Dio dio}) {
    return _MainApi(dio);
  }

  @GET("genres/anime")
  Future<BaseDataListResDto<GenericEntryDto>> getAnimeGenres();

  @GET("top/anime")
  Future<BasePaginationResDto<AnimeDto>> getTopAnime({
    @Query("page") int page = 1,
    @Query("limit") int limit = 20,
    @Query("filter") String? filter,
    @Query("type") String? type,
  });

  @GET("schedules")
  Future<BasePaginationResDto<AnimeDto>> getAnimeByAiringSchedule({
    @Query("page") int page = 1,
    @Query("limit") int limit = 20,
    @Query("filter") String? filter,
    @Query("sfw") bool? sfw = true,
    @Query("kids") bool? kids = false,
  });

  @GET("random/anime")
  Future<BaseDataResDto<AnimeDto>> getRandomAnime();
}
