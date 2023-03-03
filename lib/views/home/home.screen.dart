import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mal_clone/core/navigation/routes.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';
import 'package:mal_clone/views/home/section/browse_by_airing_date.section.dart';
import 'package:mal_clone/views/home/section/genre.section.dart';
import 'package:mal_clone/views/home/section/main_banner.section.dart';
import 'package:mal_clone/views/home/section/seasonal.section.dart';
import 'package:mal_clone/views/home/section/top_anime.section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenBloc homeScreenBloc;

  @override
  void initState() {
    super.initState();
    homeScreenBloc = HomeScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeScreenBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                HomeMainBanner(),
                SizedBox(height: 8),
                HomeBrowseByAiringDate(),
                SizedBox(height: 8),
                HomeGenreSection(),
                SizedBox(height: 8),
                HomeSeasonalSection(),
                SizedBox(height: 8),
                HomeTopAnimeSection(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.searchScreen),
          child: const Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}
