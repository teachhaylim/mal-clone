import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';
import 'package:mal_clone/data/models/character/character.dto.dart';
import 'package:mal_clone/data/models/person/person.dto.dart';
import 'package:mal_clone/data/models/sub_character/sub_character.dto.dart';
import 'package:mal_clone/utils/function.dart';

Future<void> showCharacterInfoSheet({required BuildContext context, required CharacterDto character}) {
  return showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (context) => CharacterInfoContent(character: character),
  );
}

class CharacterInfoContent extends StatefulWidget {
  CharacterInfoContent({Key? key, required this.character}) : super(key: key);

  final CharacterDto character;

  @override
  State<CharacterInfoContent> createState() => _CharacterInfoContentState();
}

class _CharacterInfoContentState extends State<CharacterInfoContent> {
  late final CharacterDto character;
  late final List<PersonDto> voiceActors;
  late final SubCharacterDto? subCharacter;

  @override
  void initState() {
    super.initState();
    character = widget.character;
    subCharacter = character.character;
    voiceActors = character.voiceActors ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(DesignSystem.radius8),
                child: CustomImageViewer(
                  url: subCharacter?.images?.jpg?.imageUrl,
                  height: 150,
                  width: 120,
                ),
              ),
              const SizedBox(width: DesignSystem.spacing8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toDisplayText(subCharacter?.name),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    toDisplayText(character.role),
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: DesignSystem.spacing8),
          const Divider(),
          const SizedBox(height: DesignSystem.spacing8),
          Text(
            AppLocale.voiceActorsText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (voiceActors.isEmpty) Text(AppLocale.noInfoAvailable),
          if (voiceActors.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: DesignSystem.spacing8, bottom: DesignSystem.spacing8),
                  itemCount: voiceActors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: DesignSystem.spacing8,
                    mainAxisSpacing: DesignSystem.spacing8,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final voiceActor = voiceActors[index];
                    final person = voiceActor.person;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      // onTap: () => _onViewCharacterInfo(context, character),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(DesignSystem.radius8),
                                child: CustomImageViewer(url: person?.images?.jpg?.imageUrl),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                toDisplayText(person?.name),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                toDisplayText(voiceActor.language),
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
            ),
        ],
      ),
    );
  }
}
