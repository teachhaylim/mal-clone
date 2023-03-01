import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/navigation/routes.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({Key? key}) : super(key: key);

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  late ThemeMode currentMode;

  void _changeTheme(ThemeMode mode) {
    if (currentMode == mode) return;

    Get.changeThemeMode(mode);
    setState(() => currentMode = mode);
    Get.offAllNamed(AppRoutes.mainScaffold);
  }

  @override
  void initState() {
    super.initState();
    currentMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLocale.changeThemeText),
      ),
      body: Column(
        children: [
          ListTile(
            selected: currentMode == ThemeMode.light,
            leading: const Icon(Icons.light_mode_outlined),
            title: const Text(AppLocale.lightModeText),
            onTap: () => _changeTheme(ThemeMode.light),
            trailing: currentMode == ThemeMode.light ? const Icon(Icons.check_rounded) : null,
          ),
          ListTile(
            selected: currentMode == ThemeMode.dark,
            leading: const Icon(Icons.dark_mode_rounded),
            title: const Text(AppLocale.darkModeText),
            onTap: () => _changeTheme(ThemeMode.dark),
            trailing: currentMode == ThemeMode.dark ? const Icon(Icons.check_rounded) : null,
          ),
          // ListTile(
          //   leading: const Icon(Icons.computer_rounded),
          //   title: const Text(AppLocale.systemModeText),
          //   onTap: () => _changeTheme(ThemeMode.system),
          // ),
        ],
      ),
    );
  }
}
