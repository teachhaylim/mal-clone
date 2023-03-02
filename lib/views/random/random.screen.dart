import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/random/bloc/random.bloc.dart';

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

  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => randomBloc.add(const RandomGetRandomAnimeEvent()),
    // );
    scrollController = ScrollController()..addListener(fabScrollListener);
  }

  void fabScrollListener() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (isVisibleNotifier.value == true) {
        setState(() => isVisibleNotifier.value = false);
      }
    } else {
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (isVisibleNotifier.value == false) {
          setState(() => isVisibleNotifier.value = true);
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
              return CustomSkeletonLoading.boxSkeleton(
                context: context,
              );
            }

            if (state is RandomLoadedState) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      height: 1000,
                      color: Colors.amberAccent,
                    ),
                    Center(
                      child: Text(toDisplayText(state.anime.title)),
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
                  onPressed: () => randomBloc.add(const RandomGetRandomAnimeEvent()),
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
