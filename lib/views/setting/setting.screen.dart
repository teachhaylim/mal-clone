import 'package:flutter/material.dart';
import 'package:mal_clone/core/config/app_config.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/navigation/routes.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String version;

  @override
  void initState() {
    final lvVersion = getIt<AppConfig>().packageInfo.version;
    final lvBuildNumber = getIt<AppConfig>().packageInfo.buildNumber;

    version = "v$lvVersion ($lvBuildNumber)";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Center(
            child: FlutterLogo(size: 80),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged",
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 0.8, color: Colors.grey, indent: 80, endIndent: 80),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text(AppLocale.changeThemeText),
            onTap: () => Get.toNamed(AppRoutes.changeThemeScreen),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.info_rounded),
            title: const Text(AppLocale.aboutText),
            onTap: () => CustomSimpleDialog.showMessageDialog(context: context, message: ""),
          ),
          const Spacer(),
          Text(version),
          const SizedBox(height: 8),
          const Text(AppLocale.madeWithText),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
