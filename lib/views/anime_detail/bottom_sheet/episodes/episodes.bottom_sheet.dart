import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_loading_indicator.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/extensions/date_time.ext.dart';
import 'package:mal_clone/extensions/misc.ext.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/episodes/bloc/episodes.bottom_sheet.bloc.dart';

Future<void> showEpisodesSheet({required BuildContext context, required AnimeDto anime}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => EpisodesContent(anime: anime),
  );
}

class EpisodesContent extends StatefulWidget {
  EpisodesContent({Key? key, required this.anime}) : super(key: key);

  final AnimeDto anime;

  @override
  State<EpisodesContent> createState() => _EpisodesContentState();
}

class _EpisodesContentState extends State<EpisodesContent> {
  late final AnimeDto anime;
  late final EpisodesBottomSheetBloc episodesBottomSheetBloc;
  final ScrollController _scrollController = ScrollController();
  final duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
    episodesBottomSheetBloc = EpisodesBottomSheetBloc(animeId: anime.malId ?? -1)..add(const EpisodesBottomSheetGetEpisodesEvent());
    _scrollController.addListener(_handleLoadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleLoadMore);
    super.dispose();
  }

  void _handleLoadMore() => _scrollController.isBottom && episodesBottomSheetBloc.state.hasMore ? episodesBottomSheetBloc.add(const EpisodesBottomSheetGetMoreEvent()) : null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => episodesBottomSheetBloc,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
        child: BlocConsumer<EpisodesBottomSheetBloc, EpisodesBottomSheetState>(
          listener: (context, state) {
            if (state.status.isError && state.error != null) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error!.message,
              );
            }
          },
          builder: (context, state) {
            if (state.status.isLoading || state.status.isInitial) {
              return CustomSkeletonLoading.boxSkeleton(rounded: DesignSystem.radius8);
            }

            if (state.status.isError || state.status.isLoaded || state.status.isProcessing) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.allEpisodesText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: DesignSystem.spacing4),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: state.episodes.length,
                        separatorBuilder: (context, index) => const SizedBox(height: DesignSystem.spacing8),
                        itemBuilder: (context, index) {
                          final episode = state.episodes[index];

                          return ListTile(
                            dense: true,
                            isThreeLine: true,
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            style: ListTileStyle.drawer,
                            contentPadding: EdgeInsets.zero,
                            title: Text(toDisplayText(episode.title)),
                            leading: Text(toDisplayText(index + 1)),
                            trailing: TextButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.star_rounded, color: Colors.yellow, size: 24),
                              label: Text(toDisplayText(episode.score)),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(toDisplayText(parseDate(dateString: episode.aired ?? "")?.formatDate())),
                                if ((episode.filler ?? false) || (episode.recap ?? false))
                                  Row(
                                    children: [
                                      if (episode.filler ?? false)
                                        Chip(
                                          label: Text(AppLocale.filler),
                                          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                        ),
                                      if (episode.filler ?? false) const SizedBox(width: DesignSystem.spacing8),
                                      if (episode.recap ?? false)
                                        Chip(
                                          label: Text(AppLocale.recap),
                                          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (state.status.isProcessing)
                      AnimatedSlide(
                        duration: duration,
                        offset: state.status.isProcessing ? Offset.zero : const Offset(0, 2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: DesignSystem.spacing8),
                          child: Center(child: CustomLoadingIndicator.loadingIndicator),
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
