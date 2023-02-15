import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';

class HomeSeasonalSection extends StatefulWidget {
  const HomeSeasonalSection({Key? key}) : super(key: key);

  @override
  State<HomeSeasonalSection> createState() => _HomeSeasonalSectionState();
}

class _HomeSeasonalSectionState extends State<HomeSeasonalSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(const HomeScreenGetSeasonalAnimeEvent());
  }

  void _onAnimeTap(AnimeDto anime) {
    logger.i(anime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocale.homeSeasonalAnimeText,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
              ),
              Text(
                "${DateTime.now().year} - ${SeasonEnum.currentSeason.name.toUpperCase()}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (pre, cur) => cur is HomeScreenSeasonalAnimeLoadedState || (cur is HomeScreenLoadingState && cur.section == HomeScreenSectionEnum.seasonalAnime),
            builder: (context, state) {
              if (state is HomeScreenLoadingState && state.section == HomeScreenSectionEnum.seasonalAnime) {
                return Container(
                  height: double.infinity,
                  color: Colors.grey.shade700,
                );
              }

              if (state is HomeScreenSeasonalAnimeLoadedState) {
                return ListView.separated(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.anime.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final anime = state.anime[index];

                    return GestureDetector(
                      onTap: () => _onAnimeTap(anime),
                      child: Card(
                        child: Container(
                          width: 150,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: CustomImageViewer(url: anime.images?.jpg?.imageUrl),
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    state.anime[index].title ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
