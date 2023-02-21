import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/widget/custom_loading_indicator.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/extensions/misc.ext.dart';
import 'package:mal_clone/views/current_airing/bloc/current_airing.bloc.dart';
import 'package:mal_clone/views/share_components/anime_item_grid.dart';

class CurrentAiringScreen extends StatefulWidget {
  const CurrentAiringScreen({Key? key}) : super(key: key);

  @override
  State<CurrentAiringScreen> createState() => _CurrentAiringScreenState();
}

class _CurrentAiringScreenState extends State<CurrentAiringScreen> {
  int airingDayIndex = Get.arguments as int;
  late final CurrentAiringBloc currentAiringBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentAiringBloc = CurrentAiringBloc()..add(CurrentAiringGetAiringEvent(day: AppConstant.airingDays[airingDayIndex].toLowerCase()));
    _scrollController.addListener(_handleLoadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleLoadMore);
    super.dispose();
  }

  void _handleLoadMore() => _scrollController.isBottom && currentAiringBloc.state.hasMore ? currentAiringBloc.add(CurrentAiringGetMoreAiringEvent(day: AppConstant.airingDays[airingDayIndex].toLowerCase())) : null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => currentAiringBloc,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocale.currentAiringTitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20)),
              Text(AppConstant.airingDays[airingDayIndex], style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey)),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await showModalBottomSheet<int>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 8),
                              child: Text("Airing Date", style: Theme.of(context).textTheme.titleMedium),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: AppConstant.airingDays.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 0),
                              itemBuilder: (context, index) => ListTile(
                                dense: true,
                                onTap: () => Navigator.of(context).pop(index),
                                leading: Radio(
                                  value: AppConstant.airingDays[index],
                                  groupValue: AppConstant.airingDays[airingDayIndex],
                                  onChanged: (value) {
                                    if (value == null) return;
                                    Navigator.of(context).pop(AppConstant.airingDays.indexOf(value));
                                  },
                                ),
                                title: Text(AppConstant.airingDays[index]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (result != null) {
                  setState(() => airingDayIndex = result);
                  currentAiringBloc.add(CurrentAiringGetAiringEvent(day: AppConstant.airingDays[airingDayIndex].toLowerCase()));
                }
              },
              icon: const Icon(Icons.filter_alt_rounded),
            ),
          ],
        ),
        body: BlocConsumer<CurrentAiringBloc, CurrentAiringState>(
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
              return GridView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => CustomSkeletonLoading.boxSkeleton(
                  context: context,
                  rounded: 12,
                ),
              );
            }

            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    itemCount: state.anime.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) => AnimeItemGrid(
                      anime: state.anime[index],
                    ),
                  ),
                  if (state.status.isProcessing)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomLoadingIndicator.loadingIndicator,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
