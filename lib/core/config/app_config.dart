import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  final PackageInfo packageInfo;
  final AndroidDeviceInfo androidInfo;
  final IosDeviceInfo iosInfo;

  const AppConfig(
      {required this.packageInfo,
      required this.androidInfo,
      required this.iosInfo});
}
