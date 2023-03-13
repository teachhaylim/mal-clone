import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/airing_status.enum.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/enums/order_by.enum.dart';
import 'package:mal_clone/data/enums/rating.enum.dart';
import 'package:mal_clone/data/enums/sort_by.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/data/models/episode/episode.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/image/image/image.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/data/models/stats/stats.dto.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/data/models/theme_song/theme_song.dto.dart';

abstract class AnimeRepo {
  Future<ApiResponse<AnimeDto>> getAnimeById({required int animeId});
  Future<ApiResponse<AnimeDto>> getAnimeByIdFull({required int animeId});
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
  });
  Future<ApiResponse<List<StreamingServiceDto>>> getAnimeStreamingServices({required int animeId});
  Future<ApiResponse<List<RelationDto>>> getAnimeRelations({required int animeId});
  Future<ApiResponse<List<CharacterDto>>> getAnimeCharacters({required int animeId});
  Future<ApiResponse<BasePaginationResDto<EpisodeDto>>> getAnimeEpisodes({required int animeId, int? page = 1});
  Future<ApiResponse<List<ImageDto>>> getAnimeImages({required int animeId});
  Future<ApiResponse<ThemeSongDto>> getAnimeThemeSongs({required int animeId});
  Future<ApiResponse<StatsDto>> getAnimeStatistics({required int animeId});
}
