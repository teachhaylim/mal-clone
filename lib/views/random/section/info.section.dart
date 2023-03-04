import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/anime/anime.dto.dart';
import 'package:mal_clone/utils/function.dart';

class RandomInfoSection extends StatelessWidget {
  const RandomInfoSection({super.key, required this.anime});

  final AnimeDto anime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      padding: const EdgeInsets.all(DesignSystem.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(DesignSystem.spacing16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.infoText,
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
                                    Text(AppLocale.seeMore),
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
                                    Text(AppLocale.seeLess),
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
    );
  }
}
