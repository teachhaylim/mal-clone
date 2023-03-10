import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/views/random/bloc/random.bloc.dart';
import 'package:mal_clone/views/random/components/skeleton_loading.dart';
import 'package:mal_clone/views/random/section/initial.section.dart';
import 'package:mal_clone/views/share_components/broadcast_info.dart';
import 'package:mal_clone/views/share_components/characters.dart';
import 'package:mal_clone/views/share_components/header_info.dart';
import 'package:mal_clone/views/share_components/info.dart';
import 'package:mal_clone/views/share_components/link_info.dart';
import 'package:mal_clone/views/share_components/media_info.dart';
import 'package:mal_clone/views/share_components/relations.dart';
import 'package:mal_clone/views/share_components/stats_info.dart';
import 'package:mal_clone/views/share_components/streaming_services.dart';
import 'package:palette_generator/palette_generator.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({Key? key}) : super(key: key);

  @override
  State<RandomScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<RandomScreen> {
  late final ScrollController scrollController;
  final duration = const Duration(milliseconds: 300);
  final ValueNotifier isVisibleNotifier = ValueNotifier<bool>(true);
  final RandomBloc randomBloc = RandomBloc();
  final ValueNotifier<PaletteGenerator?> backdropColorNotifier = ValueNotifier<PaletteGenerator?>(null);
  final ExpandableController descriptionExpandableController = ExpandableController();

  @override
  void initState() {
    scrollController = ScrollController()..addListener(fabScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(fabScrollListener);
  }

  void fabScrollListener() {
    final userScrollDirection = scrollController.position.userScrollDirection;

    if (userScrollDirection == ScrollDirection.reverse) {
      if (isVisibleNotifier.value == true) {
        isVisibleNotifier.value = false;
      }
    } else {
      if (userScrollDirection == ScrollDirection.forward) {
        if (isVisibleNotifier.value == false) {
          isVisibleNotifier.value = true;
        }
      }
    }
  }

  void onGetRandom() => randomBloc.add(const RandomGetRandomAnimeEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => randomBloc,
      child: Scaffold(
        body: BlocConsumer<RandomBloc, RandomState>(
          listener: (context, state) {
            if (state is RandomErrorState) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error.message,
              );
            }
          },
          // buildWhen: (pre, cur) => cur is! RandomErrorState || cur is! RandomLoadingState,
          builder: (context, state) {
            if (state is RandomInitialState) {
              return RandomInitialSection();
            }

            if (state is RandomLoadingState) {
              return RandomSkeletonLoading();
            }

            if (state is RandomLoadedState) {
              final anime = state.anime;
              final streamingServices = state.streamingServices;
              final relations = state.relations;
              final characters = state.characters;

              PaletteGenerator.fromImageProvider(NetworkImage(anime.images?.jpg?.largeImageUrl ?? "")).then((value) {
                backdropColorNotifier.value = value;
              });

              return SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    ValueListenableBuilder<PaletteGenerator?>(
                      valueListenable: backdropColorNotifier,
                      builder: (context, value, widget) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: MediaQuery.of(context).size.height / 1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              value?.vibrantColor?.color.withOpacity(0.8) ?? Colors.white.withOpacity(0.8),
                              (Get.isDarkMode ? Colors.black : Colors.white).withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: DesignSystem.spacing16),
                              height: 280,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(DesignSystem.radius12),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 8,
                                    spreadRadius: -6,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CustomImageViewer(url: anime.images?.jpg?.largeImageUrl),
                            ),
                          ),
                        ),
                        AnimeHeaderInfo(anime: anime),
                        AnimeInfo(anime: anime),
                        AnimeStatsInfo(anime: anime),
                        AnimeBroadcastInfo(anime: anime),
                        AnimeMediaInfo(anime: anime),
                        AnimeStreamingServices(streamingServices: streamingServices),
                        AnimeRelations(relations: relations),
                        AnimeCharacters(characters: characters),
                        AnimeLinkInfo(anime: anime),
                        const SizedBox(height: DesignSystem.spacing16),
                      ],
                    ),
                  ],
                ),
              );
            }

            if (state is RandomErrorState) {
              return Center(
                child: Text(state.error.message, textAlign: TextAlign.center),
              );
            }

            return Container();
          },
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: isVisibleNotifier,
          builder: (context, value, widget) {
            return AnimatedSlide(
              duration: duration,
              offset: value ? Offset.zero : const Offset(0, 2),
              child: AnimatedOpacity(
                duration: duration,
                opacity: value ? 1 : 0,
                child: FloatingActionButton.extended(
                  heroTag: "randomAnime",
                  onPressed: onGetRandom,
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text(AppLocale.surprisedMeText),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
