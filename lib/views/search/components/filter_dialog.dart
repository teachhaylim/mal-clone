import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:mal_clone/core/config/preference_key.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/data/enums/order_by.enum.dart';
import 'package:mal_clone/data/enums/rating.enum.dart';
import 'package:mal_clone/data/enums/sort_by.enum.dart';
import 'package:mal_clone/data/models/generic_entry/generic_entry.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/search/helper/args.helper.dart';

Future<ArgsHelper> showSearchFilterDialog({required BuildContext context, required ArgsHelper args}) async {
  final List<String> tabTitles = [
    AppLocale.filterDialogGenreTitle,
    AppLocale.filterDialogFilterTitle,
    AppLocale.filterDialogRatingTitle,
  ];
  final valueListenable = ValueNotifier<ArgsHelper>(args);
  bool isApplied = false;

  await showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.6,
    ),
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) {
      return DefaultTabController(
        length: tabTitles.length,
        child: Scaffold(
          appBar: TabBar(
            indicatorWeight: 3,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Theme.of(context).textTheme.titleSmall?.color,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),
            tabs: [
              ...tabTitles.map(
                (tab) => Tab(
                  height: 55,
                  text: tab,
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              GenreTabContent(valueListenable: valueListenable),
              FilterTabContent(valueListenable: valueListenable),
              RatingTabContent(valueListenable: valueListenable),
            ],
          ),
          bottomNavigationBar: FilterDialogButtons(
            onReset: () {
              isApplied = false;
              valueListenable.value = ArgsHelper(searchText: args.searchText);
            },
            onApply: () {
              isApplied = true;
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    },
  );

  return isApplied == true ? valueListenable.value : args;
}

class GenreTabContent extends StatelessWidget {
  GenreTabContent({Key? key, required this.valueListenable}) : super(key: key);

  final ValueNotifier<ArgsHelper> valueListenable;
  final List<GenericEntryDto> genres = getBox().get(AppPreference.genresKey, defaultValue: []).cast<GenericEntryDto>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, extra) {
        return ListView.separated(
          itemCount: genres.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final genre = genres[index];
            final isSelected = value.genres?.contains(genre) ?? false;

            return ListTile(
              onTap: () {
                if (isSelected) {
                  valueListenable.value = value.copyWith(genres: [...value.genres?.where((element) => element != genre) ?? []]);
                  return;
                }

                valueListenable.value = value.copyWith(genres: [...value.genres ?? [], genre]);
              },
              style: ListTileStyle.drawer,
              selected: isSelected,
              title: Text(genre.name ?? ""),
              trailing: isSelected ? const Icon(Icons.check_rounded) : null,
            );
          },
        );
      },
    );
  }
}

class FilterTabContent extends StatelessWidget {
  const FilterTabContent({Key? key, required this.valueListenable}) : super(key: key);

  final ValueNotifier<ArgsHelper> valueListenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, extra) {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverStickyHeader(
              header: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  AppLocale.filterDialogSortByTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              sliver: SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: SortByEnum.values.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final sortBy = SortByEnum.values[index];
                    final isSelected = value.sortBy == sortBy;

                    return ListTile(
                      onTap: () {
                        if (isSelected) {
                          valueListenable.value = value.copyWith(sortBy: null);
                          return;
                        }

                        valueListenable.value = value.copyWith(sortBy: sortBy);
                      },
                      style: ListTileStyle.drawer,
                      selected: isSelected,
                      title: Text(sortBy.toDisplay),
                      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
                    );
                  },
                ),
              ),
            ),
            SliverStickyHeader(
              header: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  AppLocale.filterDialogOrderByTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              sliver: SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: OrderByEnum.values.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final orderBy = OrderByEnum.values[index];
                    final isSelected = value.orderBy == orderBy;

                    return ListTile(
                      onTap: () {
                        if (isSelected) {
                          valueListenable.value = value.copyWith(orderBy: null);
                          return;
                        }

                        valueListenable.value = value.copyWith(orderBy: orderBy);
                      },
                      selected: isSelected,
                      title: Text(orderBy.toDisplay),
                      style: ListTileStyle.drawer,
                      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RatingTabContent extends StatelessWidget {
  const RatingTabContent({Key? key, required this.valueListenable}) : super(key: key);

  final ValueNotifier<ArgsHelper> valueListenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, extra) {
        return ListView.separated(
          itemCount: RatingEnum.values.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final rating = RatingEnum.values[index];
            final isSelected = value.rating == rating;

            return ListTile(
              onTap: () {
                if (isSelected) {
                  valueListenable.value = value.copyWith(rating: null);
                  return;
                }

                valueListenable.value = value.copyWith(rating: rating);
              },
              style: ListTileStyle.drawer,
              selected: isSelected,
              title: Text(rating.toDisplay),
              trailing: isSelected ? const Icon(Icons.check_rounded) : null,
            );
          },
        );
      },
    );
  }
}

class FilterDialogButtons extends StatelessWidget {
  const FilterDialogButtons({Key? key, required this.onReset, required this.onApply}) : super(key: key);

  final Function() onReset;
  final Function() onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: -6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              onPressed: onReset,
              icon: const Icon(Icons.restore_rounded),
              label: const Text(AppLocale.resetBtn),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onApply,
              icon: const Icon(Icons.checklist_rtl_rounded),
              label: const Text(AppLocale.applyBtn),
            ),
          )
        ],
      ),
    );
  }
}
