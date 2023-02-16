import 'package:flutter/material.dart';
import 'package:mal_clone/core/dialog/simple_dialog.dart';
import 'package:mal_clone/core/locale/locale.dart';

class HomeBrowseByAiringDate extends StatefulWidget {
  const HomeBrowseByAiringDate({Key? key}) : super(key: key);

  @override
  State<HomeBrowseByAiringDate> createState() => _HomeBrowseByAiringDateState();
}

class _HomeBrowseByAiringDateState extends State<HomeBrowseByAiringDate> {
  final List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            AppLocale.homeBrowseByAiringDateText,
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: daysOfWeek.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) => ActionChip(
              onPressed: () =>
                  CustomSimpleDialog.showComingSoon(context: context),
              label: Text(daysOfWeek[index]),
            ),
          ),
        ),
      ],
    );
  }
}
