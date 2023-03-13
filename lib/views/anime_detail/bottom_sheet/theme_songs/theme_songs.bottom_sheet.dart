import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/custom_url_launcher.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/bloc/common.bottom_sheet.bloc.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/theme_songs/components/them_song_item.dart';

Future<void> showThemeSongsSheet({required BuildContext context, required AnimeDto anime}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ThemeSongsContent(anime: anime),
  );
}

class ThemeSongsContent extends StatefulWidget {
  const ThemeSongsContent({super.key, required this.anime});

  final AnimeDto anime;

  @override
  State<ThemeSongsContent> createState() => _ThemeSongsContentState();
}

class _ThemeSongsContentState extends State<ThemeSongsContent> {
  late final AnimeDto anime;
  late final CommonBottomSheetBloc commonBottomSheetBloc;

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
    commonBottomSheetBloc = CommonBottomSheetBloc(animeId: anime.malId ?? -1)..add(const CommonBottomSheetGetThemeSongsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => commonBottomSheetBloc,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
        child: BlocConsumer<CommonBottomSheetBloc, CommonBottomSheetState>(
          listener: (context, state) {
            if (state is CommonBottomSheetErrorState) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error.message,
              );
            }
          },
          builder: (context, state) {
            if (state is CommonBottomSheetLoadingState) {
              return CustomSkeletonLoading.boxSkeleton(rounded: DesignSystem.radius8);
            }

            if (state is CommonBottomSheetThemeSongsLoadedState) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.themeSongsText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: DesignSystem.spacing4),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocale.openingText,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.openings.length,
                              separatorBuilder: (context, index) => const SizedBox(height: DesignSystem.spacing8),
                              itemBuilder: (context, index) {
                                final song = state.openings[index];
                                return ThemeSongItem(song: song);
                              },
                            ),
                            const SizedBox(height: DesignSystem.spacing8),
                            Text(
                              AppLocale.endingText,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.endings.length,
                              separatorBuilder: (context, index) => const SizedBox(height: DesignSystem.spacing8),
                              itemBuilder: (context, index) {
                                final song = state.endings[index];
                                return ThemeSongItem(song: song);
                              },
                            ),
                            const SizedBox(height: DesignSystem.spacing16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
