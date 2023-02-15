import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';

abstract class MainRepo {
  Future<ApiResponse<List<GenericEntryDto>>> getAnimeGenres();
}
