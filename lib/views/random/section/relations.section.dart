import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/relation/relation.dto.dart';
import 'package:mal_clone/utils/function.dart';

class RandomRelationsSection extends StatelessWidget {
  const RandomRelationsSection({Key? key, required this.relations}) : super(key: key);

  final List<RelationDto> relations;

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
            AppLocale.relationsText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: DesignSystem.spacing8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: relations.length,
            itemBuilder: (context, index) {
              final relation = relations[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: DesignSystem.spacing8,
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                isThreeLine: false,
                title: Text(toDisplayText(relation.relation)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...(relation.entry ?? []).map(
                      (entry) => Text(
                        toDisplayText(entry.name),
                      ),
                    ),
                  ],
                ),
                leading: Icon(Icons.home_max),
                // trailing: Icon(Icons.home_mini_rounded),
                onTap: () {},
              );
            },
          ),
          // Wrap(
          //   runSpacing: DesignSystem.spacing8,
          //   spacing: DesignSystem.spacing8,
          //   children: [
          //     ...streamingServices.map(
          //       (service) => Chip(
          //         labelStyle: Theme.of(context).textTheme.bodyMedium,
          //         visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          //         label: Text(toDisplayText(service.name)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
