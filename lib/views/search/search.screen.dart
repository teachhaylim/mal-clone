import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/views/search/components/filter_dialog.dart';
import 'package:mal_clone/views/search/helper/args.helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  ArgsHelper args = Get.arguments ?? ArgsHelper();
  late final ValueNotifier isFilteredListenable;
  late final ValueNotifier<ArgsHelper> argsListenable;

  @override
  void initState() {
    super.initState();
    isFilteredListenable = ValueNotifier(args.isFiltered);
    argsListenable = ValueNotifier(args);
    searchController = TextEditingController(text: args.searchText);
    argsListenable.addListener(onArgsListenableChange);
  }

  void onArgsListenableChange() {
    isFilteredListenable.value = argsListenable.value.isFiltered;
    searchController
      ..text = argsListenable.value.searchText ?? ""
      ..selection = TextSelection.collapsed(offset: argsListenable.value.searchText?.length ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: ValueListenableBuilder<ArgsHelper>(
          valueListenable: argsListenable,
          builder: (context, value, widget) {
            return TextFormField(
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              textAlignVertical: TextAlignVertical.center,
              controller: searchController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                argsListenable.value = args.copyWith(searchText: value.isEmpty ? null : value);
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
                    args = newArgs;
                    argsListenable.value = newArgs;
                  });
                },
                icon: value ? Icon(Icons.filter_alt_rounded, color: Theme.of(context).colorScheme.primary) : const Icon(Icons.filter_alt_off_rounded),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
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
        },
      ),
    );
  }
}
