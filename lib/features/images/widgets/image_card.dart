import 'package:flutter/material.dart';
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
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // todo : improve image loading performance
              child: Image.network(
                dashboardImageData.imageUrl,
                height: 200,
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
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
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
