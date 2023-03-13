import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/config/color.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/anime_detail/bottom_sheet/bloc/common.bottom_sheet.bloc.dart';

Future<void> showStatsRatingSheet({required BuildContext context, required AnimeDto anime}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => StatsRatingContent(anime: anime),
  );
}

class StatsRatingContent extends StatefulWidget {
  const StatsRatingContent({super.key, required this.anime});

  final AnimeDto anime;

  @override
  State<StatsRatingContent> createState() => _StatsRatingContentState();
}

class _StatsRatingContentState extends State<StatsRatingContent> {
  late final AnimeDto anime;
  late final CommonBottomSheetBloc commonBottomSheetBloc;

  @override
  void initState() {
    super.initState();
    anime = widget.anime;
    commonBottomSheetBloc = CommonBottomSheetBloc(animeId: anime.malId ?? -1)..add(const CommonBottomSheetGetStatsRatingEvent());
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = false;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.amberAccent,
            // color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/ophthalmology-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.pinkAccent,
            // color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/librarian-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            // color: AppColors.contentColorPurple,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/fitness-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.greenAccent,
            // color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/worker-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
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

            if (state is CommonBottomSheetStatsRatingLoadedState) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.statsRatingText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: DesignSystem.spacing4),
                    Expanded(
                      child: Column(
                        children: [
                          Text(toDisplayText(anime.score)),
                          LinearProgressIndicator(
                            value: 34.8 / 100,
                            minHeight: 20,
                            // backgroundColor: AppColors.primaryColor,
                            // color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: DesignSystem.spacing8),
                          LinearProgressIndicator(
                            value: 28.3 / 100,
                            minHeight: 20,
                          ),
                          const SizedBox(height: DesignSystem.spacing8),
                          LinearProgressIndicator(
                            value: 21.1 / 100,
                            minHeight: 20,
                          ),
                          const SizedBox(height: DesignSystem.spacing8),
                          LinearProgressIndicator(
                            value: 3.3 / 100,
                            minHeight: 20,
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: PieChart(
                    //     PieChartData(
                    //       pieTouchData: PieTouchData(
                    //         touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    //           // setState(() {
                    //           //   if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                    //           //     touchedIndex = -1;
                    //           //     return;
                    //           //   }
                    //           //   touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    //           // });
                    //         },
                    //       ),
                    //       borderData: FlBorderData(
                    //         show: false,
                    //       ),
                    //       sectionsSpace: 0,
                    //       centerSpaceRadius: 0,
                    //       sections: showingSections(),
                    //     ),

                    //     swapAnimationDuration: Duration(milliseconds: 150), // Optional
                    //     swapAnimationCurve: Curves.linear, // Optional
                    //   ),
                    // ),
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
