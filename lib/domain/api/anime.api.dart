import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/data/models/episode/episode.dto.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/data/models/network/base_data_list_res/base_data_list_res.dto.dart';
import 'package:mal_clone/data/models/network/base_data_res/base_data_res.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/stats/stats.dto.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/data/models/theme_song/theme_song.dto.dart';
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

  @GET("anime")
  Future<BasePaginationResDto<AnimeDto>> searchAnime({
    @Query("page") int? page = 1,
    @Query("limit") int? limit = 10,
    @Query("q") String? searchText,
    @Query("type") String? type,
    @Query("score") double? score,
    @Query("min_score") double? minScore,
    @Query("max_score") double? maxScore,
    @Query("status") String? airingStatus,
    @Query("rating") String? rating,
    @Query("sfw") bool? sfw,
    @Query("genres") String? genres,
    @Query("genres_exclude") String? genresExclude,
    @Query("order_by") String? orderBy,
    @Query("sort") String? sortBy,
    @Query("letter") String? letter,
    @Query("producers") String? producers,
    @Query("start_date") String? startDate,
    @Query("end_date") String? endDate,
  });

  @GET("anime/{id}/streaming")
  Future<BaseDataListResDto<StreamingServiceDto>> getAnimeStreamingServices({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/relations")
  Future<BaseDataListResDto<RelationDto>> getAnimeRelations({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/characters")
  Future<BaseDataListResDto<CharacterDto>> getAnimeCharacters({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/episodes")
  Future<BasePaginationResDto<EpisodeDto>> getAnimeEpisodes({
    @Path("id") required String animeId,
    @Query("page") int? page = 1,
  });

  @GET("anime/{id}/pictures")
  Future<BaseDataListResDto<ImageDto>> getAnimeImages({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/themes")
  Future<BaseDataResDto<ThemeSongDto>> getAnimeThemeSongs({
    @Path("id") required String animeId,
  });

  @GET("anime/{id}/statistics")
  Future<BaseDataResDto<StatsDto>> getAnimeStatistics({
    @Path("id") required String animeId,
  });
}
