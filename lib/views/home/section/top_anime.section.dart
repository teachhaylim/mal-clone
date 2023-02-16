import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';
import 'package:mal_clone/views/home/components/list_item_horizontal.dart';

class HomeTopAnimeSection extends StatefulWidget {
  const HomeTopAnimeSection({Key? key}) : super(key: key);

  @override
  State<HomeTopAnimeSection> createState() => _HomeTopAnimeSectionState();
}

class _HomeTopAnimeSectionState extends State<HomeTopAnimeSection> {
  late HomeScreenBloc homeScreenBloc;

  @override
  void initState() {
    super.initState();
    homeScreenBloc = context.read<HomeScreenBloc>()..add(const HomeScreenGetTopAnimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocale.homeTopAnimeText,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
              ),
              IconButton(
                onPressed: () => CustomSimpleDialog.showComingSoon(context: context),
                icon: const Icon(Icons.arrow_circle_right_outlined),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (pre, cur) => cur is HomeScreenTopAnimeLoadedState || (cur is HomeScreenLoadingState && cur.section == HomeScreenSectionEnum.topAnime),
            builder: (context, state) {
              if (state is HomeScreenLoadingState && state.section == HomeScreenSectionEnum.topAnime) {
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => CustomSkeletonLoading.boxSkeleton(context: context, rounded: 13, width: 150),
                );
              }

              if (state is HomeScreenTopAnimeLoadedState) {
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.anime.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
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
