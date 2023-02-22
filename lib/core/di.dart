import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mal_clone/core/config/app_config.dart';
import 'package:mal_clone/core/config/preference_key.dart';
import 'package:mal_clone/core/network/api_request.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/domain/api/anime.api.dart';
import 'package:mal_clone/domain/api/main.api.dart';
import 'package:mal_clone/domain/api/season.api.dart';
import 'package:mal_clone/domain/repo/anime.repo.dart';
import 'package:mal_clone/domain/repo/main.repo.dart';
import 'package:mal_clone/domain/repo/season.repo.dart';
import 'package:mal_clone/domain/repo_impl/anime.repo.impl.dart';
import 'package:mal_clone/domain/repo_impl/main.repo.impl.dart';
import 'package:mal_clone/domain/repo_impl/season.repo.impl.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

final GetIt getIt = GetIt.instance;
final Logger logger = Logger();

Future<void> initializeApp() async {
  Hive.registerAdapter(GenericEntryDtoAdapter());
  await Hive.openBox(AppPreference.hiveBox);

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

  //! Configuration
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<AppConfig>(() => AppConfig(packageInfo: packageInfo, androidInfo: androidInfo, iosInfo: iosInfo));

  //! API
  getIt.registerLazySingleton<AnimeApi>(() => AnimeApi(dio: getIt()));
  getIt.registerLazySingleton<SeasonApi>(() => SeasonApi(dio: getIt()));
  getIt.registerLazySingleton<MainApi>(() => MainApi(dio: getIt()));

  //! Repo
  getIt.registerLazySingleton<AnimeRepo>(() => AnimeRepoImpl(animeApi: getIt()));
  getIt.registerLazySingleton<SeasonRepo>(() => SeasonRepoImpl(seasonApi: getIt()));
  getIt.registerLazySingleton<MainRepo>(() => MainRepoImpl(mainApi: getIt()));
}
