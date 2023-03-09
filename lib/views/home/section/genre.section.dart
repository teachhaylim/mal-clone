import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/navigation/routes.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';
import 'package:mal_clone/views/search/helper/args.helper.dart';

class HomeGenreSection extends StatefulWidget {
  const HomeGenreSection({Key? key}) : super(key: key);

  @override
  State<HomeGenreSection> createState() => _HomeGenreSectionState();
}

class _HomeGenreSectionState extends State<HomeGenreSection> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(const HomeScreenGetGenresEvent());
  }

  void _onGenreTap(GenericEntryDto genre) => Get.toNamed(AppRoutes.searchScreen, arguments: ArgsHelper(genres: [genre]));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            AppLocale.homeGenresText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 150,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (pre, cur) => cur is HomeScreenGenresLoadedState || (cur is HomeScreenLoadingState && cur.section == HomeScreenSectionEnum.genre),
            builder: (context, state) {
              if (state is HomeScreenLoadingState && state.section == HomeScreenSectionEnum.genre) {
                return CustomSkeletonLoading.boxSkeleton(paddingLeft: 16, paddingRight: 16, rounded: 13);
              }

              if (state is HomeScreenGenresLoadedState) {
                return GridView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1 / 3,
                  ),
                  itemCount: state.genres.length >= 20 ? 21 : state.genres.length,
                  itemBuilder: (context, index) {
                    if (index == 20) {
                      return SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              minimumSize: const Size(double.infinity, double.infinity),
                            ),
                            onPressed: () => Get.toNamed(AppRoutes.genreListScreen),
                            child: const Text("View More"),
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () => _onGenreTap(state.genres[index]),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            state.genres[index].name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
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
