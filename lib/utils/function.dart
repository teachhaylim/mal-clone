import 'package:hive_flutter/hive_flutter.dart';
import 'package:mal_clone/core/config/preference_key.dart';

Box<dynamic> getBox() {
  return Hive.box(AppPreference.hiveBox);
}
