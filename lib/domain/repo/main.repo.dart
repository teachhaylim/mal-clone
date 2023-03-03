import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/airing_status.enum.dart';
import 'package:mal_clone/data/enums/filter.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/network/base_pagination_res/base_pagination_res.dto.dart';

abstract class MainRepo {
  Future<ApiResponse<List<GenericEntryDto>>> getAnimeGenres();
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getTopAnime({int page = 1, int limit = 20, FilterEnum? filter, AiringStatusEnum? type});
  Future<ApiResponse<BasePaginationResDto<AnimeDto>>> getAnimeByAiringSchedule({int page = 1, int limit = 20, required String day, bool sfw = true, bool kids = false});
  Future<ApiResponse<AnimeDto>> getRandomAnime();
}
