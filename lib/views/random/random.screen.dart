import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/extensions/number.ext.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/random/bloc/random.bloc.dart';
import 'package:mal_clone/views/share_components/star_rating.dart';
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
  // final GlobalKey webViewKey = GlobalKey();
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //   crossPlatform: InAppWebViewOptions(
  //     cacheEnabled: false,
  //     clearCache: true,
  //     useShouldOverrideUrlLoading: true,
  //     mediaPlaybackRequiresUserGesture: false,
  //   ),
  //   android: AndroidInAppWebViewOptions(
  //     useHybridComposition: true,
  //   ),
  //   ios: IOSInAppWebViewOptions(
  //     allowsInlineMediaPlayback: true,
  //   ),
  // );
  // late InAppWebViewController webViewController;
  final ExpandableController descriptionExpandableController = ExpandableController();

  @override
  void initState() {
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => randomBloc.add(const RandomGetRandomAnimeEvent()),
    // );
    scrollController = ScrollController()..addListener(fabScrollListener);

    super.initState();
  }

  void fabScrollListener() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (isVisibleNotifier.value == true) {
        isVisibleNotifier.value = false;
      }
    } else {
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (isVisibleNotifier.value == false) {
          isVisibleNotifier.value = true;
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(fabScrollListener);
  }

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
            if (state is RandomInitialState || state is RandomLoadingState) {
              return CustomSkeletonLoading.boxSkeleton(context: context);
            }

            if (state is RandomLoadedState) {
              final anime = state.anime;

              PaletteGenerator.fromImageProvider(NetworkImage(anime.images?.jpg?.imageUrl ?? "")).then((value) {
                backdropColor.value = value;
              });

              return SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    ValueListenableBuilder<PaletteGenerator?>(
                      valueListenable: backdropColor,
                      builder: (context, value, widget) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            // borderRadius: const BorderRadius.only(
                            //   bottomLeft: Radius.circular(DesignSystem.radius12),
                            //   bottomRight: Radius.circular(DesignSystem.radius12),
                            // ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                value?.dominantColor?.color.withOpacity(.8) ?? Colors.transparent,
                                Colors.black.withOpacity(.8),
                              ],
                            ),
                          ),
                        );
                      },
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
                                url: anime.images?.jpg?.imageUrl,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(DesignSystem.radius8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                toDisplayText(anime.titleEnglish),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: DesignSystem.spacing4),
                              Text(
                                toDisplayText(anime.titleJapanese),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: DesignSystem.spacing8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Chip(
                                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    label: Text(toDisplayText(anime.type)),
                                  ),
                                  const SizedBox(width: DesignSystem.spacing8),
                                  Chip(
                                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    label: Text(toDisplayText(anime.source)),
                                  ),
                                  const SizedBox(width: DesignSystem.spacing8),
                                  Chip(
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    label: StarRating(
                                      ratingValue: anime.score,
                                      textStyle: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
                          padding: const EdgeInsets.all(DesignSystem.spacing16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            borderRadius: BorderRadius.circular(DesignSystem.spacing16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Info",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                              ),
                              Builder(
                                builder: (context) {
                                  if (anime.synopsis != null) {
                                    return ExpandableNotifier(
                                      child: Column(
                                        children: [
                                          Expandable(
                                            collapsed: ExpandableButton(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    toDisplayText(anime.synopsis),
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: DesignSystem.spacing8),
                                                  ExpandableButton(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: const [
                                                        Icon(Icons.keyboard_arrow_down_rounded),
                                                        Text("See more"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            expanded: ExpandableButton(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    toDisplayText(anime.synopsis),
                                                    softWrap: true,
                                                  ),
                                                  const SizedBox(height: DesignSystem.spacing8),
                                                  ExpandableButton(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: const [
                                                        Icon(Icons.keyboard_arrow_up_rounded),
                                                        Text("See less"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return Text(toDisplayText(anime.synopsis), softWrap: true);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
                          padding: const EdgeInsets.all(DesignSystem.spacing16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            borderRadius: BorderRadius.circular(DesignSystem.spacing16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stats info",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.supervisor_account_rounded),
                                          const Text("Members"),
                                          Text(toDisplayText(anime.members?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.heart_broken_rounded),
                                          const Text("Favorites"),
                                          Text(toDisplayText(anime.favorites?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.star_rounded),
                                          const Text("Popularity"),
                                          Text(toDisplayText(anime.popularity?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.insert_chart_outlined_rounded),
                                          const Text("Ranking"),
                                          Text(toDisplayText(anime.rank?.toShorten), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
                          padding: const EdgeInsets.all(DesignSystem.spacing16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            borderRadius: BorderRadius.circular(DesignSystem.spacing16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Broadcast info",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: DesignSystem.spacing16),
                          padding: const EdgeInsets.all(DesignSystem.spacing16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            borderRadius: BorderRadius.circular(DesignSystem.spacing16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Media",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: DesignSystem.spacing8),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.movie_creation_rounded),
                                label: const Text("Trailer"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: DesignSystem.spacing16),
                      ],
                    ),
                  ],
                ),
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
                  onPressed: () {
                    randomBloc.add(const RandomGetRandomAnimeEvent());
                  },
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text("Surprised Me!"),
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
