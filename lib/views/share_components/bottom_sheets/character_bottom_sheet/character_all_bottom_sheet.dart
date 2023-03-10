import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/utils/function.dart';
import 'package:mal_clone/views/share_components/bottom_sheets/character_bottom_sheet/character_info.bottom_sheet.dart';

Future<void> showAllCharactersSheet({required BuildContext context, required List<CharacterDto> characters}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => CharacterAllContent(characters: characters),
  );
}

class CharacterAllContent extends StatefulWidget {
  CharacterAllContent({Key? key, required this.characters}) : super(key: key);

  final List<CharacterDto> characters;

  @override
  State<CharacterAllContent> createState() => _CharacterAllContentState();
}

class _CharacterAllContentState extends State<CharacterAllContent> {
  late final List<CharacterDto> characters;

  @override
  void initState() {
    super.initState();
    characters = widget.characters;
  }

  void _onViewCharacterInfo(BuildContext context, CharacterDto character) {
    Navigator.of(context).pop();
    showCharacterInfoSheet(
      context: context,
      character: character,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.allCharactersText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: DesignSystem.spacing4),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: DesignSystem.spacing8),
              itemCount: characters.length,
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
          ),
        ],
      ),
    );
  }
}
