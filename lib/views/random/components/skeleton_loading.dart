import 'package:flutter/material.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/core/widget/custom_skeleton_loading.dart';

class RandomSkeletonLoading extends StatelessWidget {
  const RandomSkeletonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: DesignSystem.spacing16),
              child: CustomSkeletonLoading.boxSkeleton(
                height: 250,
                width: 180,
                rounded: DesignSystem.radius8,
              ),
            ),
          ),
          CustomSkeletonLoading.boxSkeleton(
            height: 25,
            width: 220,
            rounded: DesignSystem.radius100,
            paddingTop: DesignSystem.spacing16,
          ),
          CustomSkeletonLoading.boxSkeleton(
            height: 25,
            width: 140,
            rounded: DesignSystem.radius100,
            paddingTop: DesignSystem.spacing8,
          ),
          SizedBox(
            height: 35,
            child: ListView.builder(
              padding: EdgeInsets.only(top: DesignSystem.spacing16),
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomSkeletonLoading.boxSkeleton(
                  width: 100,
                  rounded: DesignSystem.radius100,
                  paddingLeft: DesignSystem.spacing4,
                  paddingRight: DesignSystem.spacing4,
                );
              },
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CustomSkeletonLoading.boxSkeleton(
                height: 250,
                rounded: DesignSystem.radius8,
                paddingTop: DesignSystem.spacing16,
                paddingLeft: DesignSystem.spacing16,
                paddingRight: DesignSystem.spacing16,
              );
            },
          ),
          const SizedBox(height: DesignSystem.spacing8, width: double.infinity),
        ],
      ),
    );
  }
}
