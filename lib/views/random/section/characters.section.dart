import 'package:flutter/material.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/share_components/bottom_sheets/character_bottom_sheet/character_all_bottom_sheet.dart';
import 'package:mal_clone/views/share_components/bottom_sheets/character_bottom_sheet/character_info.bottom_sheet.dart';

class RandomCharactersSection extends StatelessWidget {
  const RandomCharactersSection({Key? key, required this.characters}) : super(key: key);

  final List<CharacterDto> characters;

  void _onViewMore(BuildContext context, List<CharacterDto> characters) {
    showAllCharactersSheet(
      context: context,
      characters: characters,
    );
  }

  void _onViewCharacterInfo(BuildContext context, CharacterDto character) {
    showCharacterInfoSheet(
      context: context,
      character: character,
    );
  }

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
            AppLocale.charactersText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          if (characters.isEmpty) Text(AppLocale.noInfoAvailable),
          if (characters.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: DesignSystem.spacing8, bottom: DesignSystem.spacing8),
              itemCount: characters.take(9).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: DesignSystem.spacing8,
                mainAxisSpacing: DesignSystem.spacing8,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final character = characters[index];

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onViewCharacterInfo(context, character),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(DesignSystem.radius8),
                            child: CustomImageViewer(url: character.character?.images?.jpg?.imageUrl),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            toDisplayText(character.character?.name),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            toDisplayText(character.role),
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade600, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          if (characters.length > 9)
            OutlinedButton.icon(
              onPressed: () => _onViewMore(context, characters),
              icon: Icon(Icons.arrow_circle_right_outlined),
              label: Text(AppLocale.seeMore),
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, ButtonTheme.of(context).height),
              ),
            ),
        ],
      ),
    );
  }
}
