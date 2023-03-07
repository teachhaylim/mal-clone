import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/random/bloc/random.bloc.dart';
import 'package:mal_clone/views/random/section/broadcast_info.section.dart';
import 'package:mal_clone/views/random/section/header_info.section.dart';
import 'package:mal_clone/views/random/section/info.section.dart';
import 'package:mal_clone/views/random/section/initial.section.dart';
import 'package:mal_clone/views/random/section/link_info.section.dart';
import 'package:mal_clone/views/random/section/media_info.section.dart';
import 'package:mal_clone/views/random/section/relations.section.dart';
import 'package:mal_clone/views/random/section/stats_info.section.dart';
import 'package:mal_clone/views/random/section/streaming_services.section.dart';
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
  final ValueNotifier<PaletteGenerator?> backdropColor = ValueNotifier<PaletteGenerator?>(null);
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
          builder: (context, state) {
            if (state is RandomInitialState) {
              return RandomInitialSection();
            }

            if (state is RandomLoadingState) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      CustomSkeletonLoading.boxSkeleton(
                        context: context,
                        height: 250,
                      ),
                      const SizedBox(height: DesignSystem.spacing8),
                      CustomSkeletonLoading.boxSkeleton(
                        context: context,
                        height: 150,
                      ),
                      const SizedBox(height: DesignSystem.spacing8),
                      CustomSkeletonLoading.boxSkeleton(
                        context: context,
                        height: 150,
                      ),
                      const SizedBox(height: DesignSystem.spacing8),
                      CustomSkeletonLoading.boxSkeleton(
                        context: context,
                        height: 150,
                      ),
                      const SizedBox(height: DesignSystem.spacing8),
                    ],
                  ),
                ),
              );
            }

            if (state is RandomLoadedState) {
              final anime = state.anime;
              final streamingServices = state.streamingServices;
              final relations = state.relations;

              PaletteGenerator.fromImageProvider(NetworkImage(anime.images?.jpg?.largeImageUrl ?? "")).then((value) {
                backdropColor.value = value;
              });

              return SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    ValueListenableBuilder<PaletteGenerator?>(
                      valueListenable: backdropColor,
                      builder: (context, value, widget) => Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              value?.vibrantColor?.color.withOpacity(0.8) ?? Colors.transparent,
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
                              height: 250,
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
                              child: CustomImageViewer(
                                url: anime.images?.jpg?.largeImageUrl,
                              ),
                            ),
                          ),
                        ),
                        RandomHeaderInfoSection(anime: anime),
                        RandomInfoSection(anime: anime),
                        RandomStatsInfoSection(anime: anime),
                        RandomBroadcastInfoSection(anime: anime),
                        RandomStreamingServicesSection(streamingServices: streamingServices),
                        RandomRelationsSection(relations: relations),
                        RandomMediaInfoSection(anime: anime),
                        RandomLinkInfoSection(anime: anime),
                        const SizedBox(height: DesignSystem.spacing16),
                      ],
                    ),
                  ],
                ),
              );
            }

            if (state is RandomErrorState) {
              return RandomInitialSection();
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
