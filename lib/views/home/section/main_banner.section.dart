import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/home/bloc/home_screen.bloc.dart';

class HomeMainBanner extends StatefulWidget {
  const HomeMainBanner({Key? key}) : super(key: key);

  @override
  State<HomeMainBanner> createState() => _HomeMainBannerState();
}

class _HomeMainBannerState extends State<HomeMainBanner> {
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
              borderRadius: BorderRadius.circular(12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 8),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // onPageChanged: (index, _) => setState(() => imageIndex = index),
                  // scrollDirection: Axis.horizontal,
                ),
                items: anime.map((item) {
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
                        padding: const EdgeInsets.only(left: 12, bottom: 8, right: 12),
                        child: Text(
                          item.title ?? "",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
