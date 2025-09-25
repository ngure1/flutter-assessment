import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';
import 'package:flutter_assessment/core/utils/text_transformation.dart';
import 'package:flutter_assessment/features/images/models/image_model.dart';
import 'package:flutter_assessment/features/images/widgets/badge_chip.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.dashboardImageData});

  final ImagesModel dashboardImageData;

  Widget _buildChips() {
    return Flexible(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: dashboardImageData.tags
              .map<Widget>((tag) => BadgeChip(label: tag))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(
          width > ScreenSize.desktop
              ? 16
              : width > ScreenSize.tablet
              ? 10
              : 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // todo : improve image loading performance
              child: Image.network(
                dashboardImageData.imageUrl,
                height: width > ScreenSize.desktop
                    ? 200
                    : width > ScreenSize.tablet
                    ? 150
                    : 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              dashboardImageData.photographerName.capitalize(),
              style: width > ScreenSize.tablet
                  ? theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )
                  : width > ScreenSize.desktop
                  ? theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    )
                  : theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
            ),
            const SizedBox(height: 12),
            _buildChips(),
          ],
        ),
      ),
    );
  }
}
