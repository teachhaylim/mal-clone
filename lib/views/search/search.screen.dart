import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/core/widget/custom_loading_indicator.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/data/enums/bloc_status.enum.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/extensions/misc.ext.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/search/bloc/search.bloc.dart';
import 'package:mal_clone/views/search/components/filter_dialog.dart';
import 'package:mal_clone/views/search/helper/args.helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  late SearchBloc searchBloc;
  ArgsHelper args = Get.arguments ?? ArgsHelper();
  late final ValueNotifier isFilteredListenable;
  late final ValueNotifier<ArgsHelper> argsListenable;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isFilteredListenable = ValueNotifier(args.isFiltered);
    argsListenable = ValueNotifier(args);
    searchController = TextEditingController(text: args.searchText);
    searchBloc = SearchBloc(filter: args);

    if (args.isFiltered) searchBloc.add(const SearchGetAnimeEvent());

    argsListenable.addListener(onArgsListenableChange);
    _scrollController.addListener(_handleLoadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleLoadMore);
    super.dispose();
  }

  void onArgsListenableChange() {
    isFilteredListenable.value = argsListenable.value.isFiltered;
    searchController
      ..text = argsListenable.value.searchText ?? ""
      ..selection = TextSelection.collapsed(offset: argsListenable.value.searchText?.length ?? 0);
  }

  void _handleLoadMore() => _scrollController.isBottom && searchBloc.state.hasMore ? searchBloc.add(const SearchLoadMoreEvent()) : null;

  void _onAnimeTap(AnimeDto anime) {
    logger.i(anime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: ValueListenableBuilder<ArgsHelper>(
            valueListenable: argsListenable,
            builder: (context, value, widget) {
              return TextFormField(
                autofocus: !args.isFiltered,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  argsListenable.value = argsListenable.value.copyWith(searchText: value.isEmpty ? null : value);
                },
                onFieldSubmitted: (value) {
                  searchBloc.add(SearchUpdateFilterEvent(filter: argsListenable.value));
                },
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  hintText: AppLocale.searchHintText,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable: isFilteredListenable,
              builder: (context, value, widget) {
                return IconButton(
                  onPressed: () async {
                    showSearchFilterDialog(
                      context: context,
                      args: argsListenable.value,
                    ).then((newArgs) {
                      if (newArgs == argsListenable.value) return;
                      argsListenable.value = newArgs;
                      searchBloc.add(SearchUpdateFilterEvent(filter: argsListenable.value));
                    });
                  },
                  icon: value ? Icon(Icons.filter_alt_rounded, color: Theme.of(context).colorScheme.primary) : const Icon(Icons.filter_alt_off_rounded),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state.status == BlocStatus.error && state.error != null) {
              return CustomSimpleDialog.showMessageDialog(
                context: context,
                message: state.error!.message,
              );
            }

            if (state.status == BlocStatus.refresh) {
              if (argsListenable.value.isFiltered) {
                searchBloc.add(const SearchGetAnimeEvent());
              }

              return;
            }
          },
          builder: (context, state) {
            if (!argsListenable.value.isFiltered) {
              return const Center(
                child: Text(AppLocale.searchHintText),
              );
            }

            if (state.status.isInitial || state.status.isLoading) {
              return ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomSkeletonLoading.boxSkeleton(height: 100),
                ),
              );
            }

            if (state.status.isProcessing || state.status.isLoaded) {
              if (state.anime.isEmpty) {
                return const Center(
                  child: Text("Empty search result"),
                );
              }

              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.anime.length,
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final anime = state.anime[index];

                        return GestureDetector(
                          onTap: () => _onAnimeTap(anime),
                          child: Card(
                            elevation: 1,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                children: [
                                  CustomImageViewer(
                                    width: 100,
                                    url: anime.images?.jpg?.largeImageUrl,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            toDisplayText(anime.title),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          Expanded(
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: (anime.genres?.length ?? 0) >= 2 ? 2 : (anime.genres?.length ?? 0),
                                              separatorBuilder: (context, index) => const SizedBox(width: 8),
                                              itemBuilder: (context, index) {
                                                final genre = anime.genres?[index];

                                                return Chip(
                                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor: Theme.of(context).colorScheme.background,
                                                  labelStyle: Theme.of(context).textTheme.subtitle2,
                                                  label: Text(toDisplayText(genre?.name)),
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.star_rate_rounded, color: Colors.yellow),
                                                  const SizedBox(width: 4),
                                                  Text(toDisplayText(anime.score)),
                                                ],
                                              ),
                                              Text(toDisplayText(anime.year)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (state.status.isProcessing)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomLoadingIndicator.loadingIndicator,
                      ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
