import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_button.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/anime_detail/bloc/anime_detail.bloc.dart';
import 'package:mal_clone/views/anime_detail/section/extra_info.section.dart';
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

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({Key? key}) : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final int animeId = Get.arguments ?? -1;
  late final AnimeDetailBloc animeDetailBloc;
  final ValueNotifier<PaletteGenerator?> backdropColorNotifier = ValueNotifier<PaletteGenerator?>(null);

  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarIconBrightness: Brightness.light,
    //       systemStatusBarContrastEnforced: true,
    //     ),
    //   ),
    // );

    animeDetailBloc = AnimeDetailBloc(animeId: animeId)..add(const AnimeDetailGetDetailEvent());
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animeDetailBloc,
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemStatusBarContrastEnforced: true,
          ),
        ),
        body: BlocConsumer<AnimeDetailBloc, AnimeDetailState>(
          listener: (context, state) {
            if (state is AnimeDetailErrorState) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error.message,
              );
            }
          },
          builder: (context, state) {
            if (state is AnimeDetailLoadingState) {
              return CustomSkeletonLoading.boxSkeleton();
            }

            if (state is AnimeDetailLoadedState) {
              final anime = state.anime;
              final streamingServices = state.streamingServices;
              final relations = state.relations;
              final characters = state.characters;

              PaletteGenerator.fromImageProvider(NetworkImage(anime.images?.jpg?.largeImageUrl ?? "")).then((value) {
                backdropColorNotifier.value = value;
              });

              return Container(
                height: MediaQuery.of(context).size.height,
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
                    CustomScrollView(
                      slivers: [
                        SliverStickyHeader(
                          header: SafeArea(
                            child: AppBar(
                              scrolledUnderElevation: 0,
                              backgroundColor: Colors.transparent,
                              leading: CustomButton.backButton(
                                onPressed: () => Get.back(),
                              ),
                            ),
                          ),
                          overlapsContent: true,
                          sliver: SliverToBoxAdapter(
                            child: Column(
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
                                AnimeDetailExtraInfoSection(anime: anime),
                                const SizedBox(height: DesignSystem.spacing16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            if (state is AnimeDetailErrorState) {
              return Center(
                child: Text(state.error.message),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
