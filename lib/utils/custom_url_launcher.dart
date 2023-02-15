import 'package:url_launcher/url_launcher.dart';

class CustomUrlLauncher {
  static Future<bool> launch({required String url}) async {
    try {
      final result = await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
      return result;
    } catch (e) {
      return false;
    }
  }
}
