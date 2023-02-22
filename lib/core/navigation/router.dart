import 'package:mal_clone/core/navigation/routes.dart';
import 'package:mal_clone/views/change_theme/change_theme.screen.dart';
import 'package:mal_clone/views/current_airing/current_airing.screen.dart';
import 'package:mal_clone/views/main_scaffold/main_scaffold.dart';
import 'package:get/route_manager.dart';
import 'package:mal_clone/views/search/search.screen.dart';

class AppRouter {
  static final appRoutes = [
    GetPage(name: AppRoutes.mainScaffold, page: () => const MainScaffold()),
    GetPage(name: AppRoutes.changeThemeScreen, page: () => const ChangeThemeScreen()),
    GetPage(name: AppRoutes.currentAiringScreen, page: () => const CurrentAiringScreen()),
    GetPage(name: AppRoutes.searchScreen, page: () => const SearchScreen()),
  ];
}
