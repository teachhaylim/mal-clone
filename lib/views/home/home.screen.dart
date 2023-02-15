import 'package:flutter/material.dart';
import 'package:mal_clone/core/di.dart';
import 'package:mal_clone/core/network/api_response.dart';
import 'package:mal_clone/data/enums/season.enum.dart';
import 'package:mal_clone/domain/repo/season.repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _getData() async {
    final res = await getIt<SeasonRepo>().getSeasonByYearNSeason(year: DateTime.now().year.toString(), season: SeasonEnum.winter);

    if (res is ApiSuccessResponse) {
      logger.i(res);
    }

    if (res is ApiErrorResponse) {
      logger.e(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          ElevatedButton(
            onPressed: _getData,
            child: const Text("Call API"),
          ),
        ],
      ),
    );
  }
}
