import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/navigation/routes.dart';

class HomeBrowseByAiringDate extends StatefulWidget {
  const HomeBrowseByAiringDate({Key? key}) : super(key: key);

  @override
  State<HomeBrowseByAiringDate> createState() => _HomeBrowseByAiringDateState();
}

class _HomeBrowseByAiringDateState extends State<HomeBrowseByAiringDate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            AppLocale.homeBrowseByAiringDateText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: AppConstant.airingDays.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) => ActionChip(
              onPressed: () => Get.toNamed(AppRoutes.currentAiringScreen, arguments: index),
              label: Text(AppConstant.airingDays[index]),
            ),
          ),
        ),
      ],
    );
  }
}
