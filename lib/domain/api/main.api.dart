import 'package:dio/dio.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/data/models/network/base_data_list_res/base_data_list_res.dto.dart';
import 'package:retrofit/retrofit.dart';

part "main.api.g.dart";

@RestApi()
abstract class MainApi {
  factory MainApi({required Dio dio}) {
    return _MainApi(dio);
  }

  @GET("genres/anime")
  Future<BaseDataListResDto<GenericEntryDto>> getAnimeGenres();
}
