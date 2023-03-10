import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';
import 'package:mal_clone/data/models/streaming_service/streaming_service.dto.dart';
import 'package:mal_clone/utils/function.dart';

class AnimeStreamingServices extends StatelessWidget {
  const AnimeStreamingServices({Key? key, required this.streamingServices}) : super(key: key);

  final List<StreamingServiceDto> streamingServices;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: DesignSystem.spacing16, right: DesignSystem.spacing16, top: DesignSystem.spacing16),
      padding: const EdgeInsets.all(DesignSystem.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(DesignSystem.spacing16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale.streamingServicesText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          if (streamingServices.isEmpty) Text(AppLocale.noInfoAvailable),
          if (streamingServices.isNotEmpty) const SizedBox(height: DesignSystem.spacing8),
          if (streamingServices.isNotEmpty)
            Wrap(
              runSpacing: DesignSystem.spacing8,
              spacing: DesignSystem.spacing8,
              children: [
                ...streamingServices.map(
                  (service) => Chip(
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    label: Text(toDisplayText(service.name)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
