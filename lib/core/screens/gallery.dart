import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/layout/desktop_and_tablet_layout.dart';
import 'package:flutter_assessment/core/layout/layout.dart';
import 'package:flutter_assessment/core/layout/mobile_layout.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      desktopAndTabletLayout: DesktopAndTabletLayout(
        body: Text("Desktop gallery page"),
      ),
      mobileLayout: MobileLayout(body: Text("Mobile gallery page")),
    );
  }
}
