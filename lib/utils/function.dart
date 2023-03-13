import 'package:hive_flutter/hive_flutter.dart';
import 'package:mal_clone/core/config/preference_key.dart';

Box<dynamic> getBox() {
  return Hive.box(AppPreference.hiveBox);
}

String toDisplayText(dynamic value) {
  switch (value.runtimeType) {
    case String:
      return value ?? "--";
    case int:
    case double:
    case bool:
      return value.toString();
    default:
      return "--";
  }
}

DateTime? parseDate({required String dateString}) {
  try {
    final date = DateTime.parse(dateString);
    return date;
  } catch (e) {
    return null;
  }
}
