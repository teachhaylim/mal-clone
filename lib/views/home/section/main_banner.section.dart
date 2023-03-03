import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeMainBanner extends StatefulWidget {
  const HomeMainBanner({Key? key}) : super(key: key);

  @override
  State<HomeMainBanner> createState() => _HomeMainBannerState();
}

class _HomeMainBannerState extends State<HomeMainBanner> {
  ValueNotifier bannerIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(const HomeScreenGetTopAnimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      buildWhen: (pre, cur) => cur is HomeScreenTopAnimeLoadedState || (cur is HomeScreenLoadingState && cur.section == HomeScreenSectionEnum.topAnime),
      builder: (context, state) {
        if (state is HomeScreenLoadingState && state.section == HomeScreenSectionEnum.topAnime) {
          return CustomSkeletonLoading.boxSkeleton(
            context: context,
            rounded: 13,
            height: 200,
            paddingLeft: 16,
            paddingRight: 16,
          );
        }

        if (state is HomeScreenTopAnimeLoadedState) {
          final anime = (state.anime.toList()..shuffle()).take(5);

          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DesignSystem.radius12),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1,
                      initialPage: bannerIndexNotifier.value,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 8),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, _) => bannerIndexNotifier.value = index,
                      // scrollDirection: Axis.horizontal,
                    ),
                    items: anime.map(
                      (item) {
                        return Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            CustomImageViewer(url: item.images?.webp?.largeImageUrl),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, bottom: 18, right: 12),
                              child: Text(
                                item.title ?? "",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                  if (anime.length > 1)
                    ValueListenableBuilder(
                      valueListenable: bannerIndexNotifier,
                      builder: (context, value, widget) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 8, right: 12),
                          child: AnimatedSmoothIndicator(
                            activeIndex: value,
                            count: anime.length,
                            effect: JumpingDotEffect(
                              verticalOffset: 4,
                              dotHeight: 6,
                              dotWidth: (MediaQuery.of(context).size.width - (10 * anime.length) - 192) / anime.length,
                              activeDotColor: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
