import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/network/base_data_list_res/base_data_list_res.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:retrofit/http.dart';

part "season.api.g.dart";

@RestApi()
abstract class SeasonApi {
  factory SeasonApi({required Dio dio}) {
    return _SeasonApi(dio);
  }

  @GET("seasons")
  Future<BaseDataListResDto<AnimeDto>> getSeason();

  @GET("seasons/{year}/{season}")
  Future<BasePaginationResDto<AnimeDto>> getSeasonByYearNSeason({
    @Path("year") required String year,
    @Path("season") required String season,
    @Query("page") int? page,
    @Query("filter") String? filter,
  });

  @GET("seasons/now")
  Future<BasePaginationResDto<AnimeDto>> getCurrentSeason({
    @Query("page") int? page,
  });

  @GET("seasons/upcoming")
  Future<BasePaginationResDto<AnimeDto>> getUpcomingSeason({
    @Query("page") int? page,
    @Query("filter") String? filter,
  });
}
