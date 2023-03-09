import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/enums/relation.enum.dart';
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
          if (relations.isEmpty) Text(AppLocale.noInfoAvailable),
          if (relations.isNotEmpty)
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: relations.length,
              itemBuilder: (context, index) {
                final relation = relations[index];
                final relationType = RelationEnum.parseRelation(relation.relation);
                final entries = relation.entry ?? [];

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: DesignSystem.spacing8,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  isThreeLine: false,
                  leading: Icon(relationType.icon),
                  title: Text(toDisplayText(relation.relation)),
                  subtitle: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    separatorBuilder: (context, index) => const SizedBox(height: DesignSystem.spacing4),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return Text(toDisplayText(entry.name));
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
