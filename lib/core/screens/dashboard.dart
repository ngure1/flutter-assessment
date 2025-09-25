import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/layout/desktop_and_tablet_layout.dart';
import 'package:flutter_assessment/core/layout/layout.dart';
import 'package:flutter_assessment/core/layout/mobile_layout.dart';
import 'package:flutter_assessment/features/images/dashboard/widgets/dashboard_images_list.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      desktopAndTabletLayout: DesktopAndTabletLayout(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: DashboardImagesList(),
        ),
      ),
      mobileLayout: MobileLayout(body: DashboardImagesList()),
    );
  }
}
