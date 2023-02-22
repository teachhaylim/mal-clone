import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/home/components/list_item_horizontal.dart';

class HomeSeasonalSection extends StatefulWidget {
  const HomeSeasonalSection({Key? key}) : super(key: key);

  @override
  State<HomeSeasonalSection> createState() => _HomeSeasonalSectionState();
}

class _HomeSeasonalSectionState extends State<HomeSeasonalSection> with TickerProviderStateMixin {
  late final TabController tabController;
  late HomeScreenBloc homeScreenBloc;
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: SeasonEnum.values.length);
    homeScreenBloc = context.read<HomeScreenBloc>()..add(const HomeScreenGetSeasonalAnimeEvent());
    tabs = SeasonEnum.values.map((e) => Tab(text: e.toDisplayText)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocale.homeSeasonalAnimeText,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                "${DateTime.now().year}",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14).copyWith(color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: TabBar(
            controller: tabController,
            indicatorWeight: 3,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Theme.of(context).textTheme.titleSmall?.color,
            labelStyle: Theme.of(context).textTheme.titleSmall,
            onTap: (index) => homeScreenBloc.add(HomeScreenGetSeasonalAnimeEvent(newSelectedSeason: SeasonEnum.values[index])),
            tabs: tabs,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (pre, cur) => cur is HomeScreenSeasonalAnimeLoadedState || (cur is HomeScreenLoadingState && cur.section == HomeScreenSectionEnum.seasonalAnime),
            builder: (context, state) {
              if (state is HomeScreenLoadingState && state.section == HomeScreenSectionEnum.seasonalAnime) {
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => CustomSkeletonLoading.boxSkeleton(context: context, rounded: 13, width: 180),
                );
              }

              if (state is HomeScreenSeasonalAnimeLoadedState) {
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.anime.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => ListItemHorizontal(anime: state.anime[index]),
                );
              }

              return Container();
            },
          ),
        ),
      ],
    );
  }
}
