import 'package:dio/dio.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/domain/api/main.api.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';

class MainRepoImpl extends MainRepo {
  final MainApi mainApi;

  MainRepoImpl({required this.mainApi});

  @override
  Future<ApiResponse<List<GenericEntryDto>>> getAnimeGenres() async {
    try {
      final res = await mainApi.getAnimeGenres();
      return ApiSuccessResponse(data: res.data);
    } on DioError catch (e) {
      return ApiResponse.parseDioError(error: e);
    } catch (e) {
      return ApiErrorResponse(message: e.toString());
    }
  }
}
