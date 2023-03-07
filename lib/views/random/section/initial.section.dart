import 'package:flutter/material.dart';
import 'package:mal_clone/core/config/constant.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_image_viewer.dart';

class RandomInitialSection extends StatelessWidget {
  const RandomInitialSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DesignSystem.radius100),
                child: CustomImageViewer(url: AppConstant.randomUnsplashImage),
              ), //TODO: add confuse image
            ),
            const SizedBox(height: DesignSystem.spacing8),
            Text(
              AppLocale.initialTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignSystem.spacing8),
            Text(
              AppLocale.initialSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
