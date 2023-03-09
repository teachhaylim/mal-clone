import 'package:flutter/material.dart';

enum RelationEnum {
  sequel,
  spinOff,
  sideStory,
  prequel,
  adaptation,
  alternativeVersion,
  alternativeSetting,
  summary,
  other;

  String get toDisplay {
    switch (this) {
      case sequel:
        return "Sequel";
      case spinOff:
        return "Spin Off";
      case sideStory:
        return "Side Story";
      case adaptation:
        return "Adaptation";
      case prequel:
        return "Prequel";
      case alternativeVersion:
        return "Alternative Version";
      case alternativeSetting:
        return "Alternative Setting";
      case summary:
        return "Summary";
      case other:
        return "Other";
    }
  }

  IconData get icon {
    switch (this) {
      case sideStory:
        return Icons.note_alt_rounded;
      case adaptation:
      case prequel:
        return Icons.book_rounded;
      case summary:
        return Icons.notes_rounded;
      case sequel:
      case spinOff:
      case alternativeVersion:
      case alternativeSetting:
        return Icons.home_max;
      case other:
        return Icons.unarchive_rounded;
    }
  }

  static RelationEnum parseRelation(String? value) {
    switch (value?.toLowerCase()) {
      case "sequel":
        return RelationEnum.sequel;
      case "spin-off":
        return RelationEnum.spinOff;
      case "side story":
        return RelationEnum.sideStory;
      case "adaptation":
        return RelationEnum.adaptation;
      case "prequel":
        return RelationEnum.prequel;
      case "alternative version":
        return RelationEnum.alternativeVersion;
      case "alternative setting":
        return RelationEnum.alternativeSetting;
      case "summary":
        return RelationEnum.summary;
      default:
        return RelationEnum.other;
    }
  }
}
