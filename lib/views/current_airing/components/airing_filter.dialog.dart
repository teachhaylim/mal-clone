import 'package:flutter/material.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/locale/locale.dart';

Future<int?> showAiringFilterDialog({required BuildContext context, required int initialIndex}) async {
  return await showModalBottomSheet<int>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(AppLocale.airingDateText, style: Theme.of(context).textTheme.titleMedium),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppConstant.airingDays.length,
                separatorBuilder: (context, index) => const SizedBox(height: 0),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  onTap: () => Navigator.of(context).pop(index),
                  leading: Radio(
                    value: AppConstant.airingDays[index],
                    groupValue: AppConstant.airingDays[initialIndex],
                    onChanged: (value) {
                      if (value == null) return;
                      Navigator.of(context).pop(AppConstant.airingDays.indexOf(value));
                    },
                  ),
                  title: Text(AppConstant.airingDays[index]),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
