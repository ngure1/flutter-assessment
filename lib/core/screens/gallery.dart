import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/layout/desktop_and_tablet_layout.dart';
import 'package:flutter_assessment/core/layout/layout.dart';
import 'package:flutter_assessment/core/layout/mobile_layout.dart';
import 'package:flutter_assessment/features/images/gallery/widgets/search_results.dart';
import 'package:flutter_assessment/features/images/gallery/widgets/search_text_field.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      desktopAndTabletLayout: DesktopAndTabletLayout(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GallerySearchTextField(),
              SizedBox(height: 12),
              GallerySearchResultsList(),
            ],
          ),
        ),
      ),
      mobileLayout: MobileLayout(body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GallerySearchTextField(),
            SizedBox(height: 12),
            GallerySearchResultsList(),
          ],
        ),
      ),
    );
  }
}
