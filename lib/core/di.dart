import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:mal_clone/core/config/app_config.dart';
import 'package:mal_clone/core/network/api_request.dart';
import 'package:mal_clone/domain/api/anime.api.dart';
import 'package:mal_clone/domain/api/season.api.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/season.repo.dart';
import 'package:mal_clone/domain/repo_impl/anime.repo.impl.dart';
import 'package:mal_clone/domain/repo_impl/season.repo.impl.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

final GetIt getIt = GetIt.instance;
final Logger logger = Logger();

Future<void> initializeApp() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<AppConfig>(() => AppConfig(packageInfo: packageInfo, androidInfo: androidInfo, iosInfo: iosInfo));

  getIt.registerLazySingleton<AnimeApi>(() => AnimeApi(dio: getIt()));
  getIt.registerLazySingleton<SeasonApi>(() => SeasonApi(dio: getIt()));

  getIt.registerLazySingleton<AnimeRepo>(() => AnimeRepoImpl(animeApi: getIt()));
  getIt.registerLazySingleton<SeasonRepo>(() => SeasonRepoImpl(seasonApi: getIt()));
}
