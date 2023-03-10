import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/views/home/home.screen.dart';
import 'package:mal_clone/views/random/random.screen.dart';
import 'package:mal_clone/views/setting/setting.screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> with TickerProviderStateMixin {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          HomeScreen(),
          RandomScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemStatusBarContrastEnforced: index == 1,
            ),
          );

          setState(() => currentPageIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: AppLocale.navigationLabelHome,
            tooltip: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.api_outlined),
            selectedIcon: Icon(Icons.api_rounded),
            label: AppLocale.navigationLabelRandom,
            tooltip: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: AppLocale.navigationLabelSetting,
            tooltip: "",
          ),
        ],
      ),
    );
  }
}
