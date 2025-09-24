import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/dashboard/models/dashboard_model.dart';

// todo : create skeleton for this card
class DashboardImageCard extends StatelessWidget {
  const DashboardImageCard({super.key, required this.dashboardImageData});

  final DashboardImagesModel dashboardImageData;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
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
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dashboardImageData.photographerName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children:
                  (dashboardImageData.tags.length > 4
                          ? dashboardImageData.tags.take(4)
                          : dashboardImageData.tags)
                      .map<Widget>((tag) {
                        return Chip(label: Text(tag));
                      })
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
