import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/app_drawer.dart';

class DesktopAndTabletLayout extends StatelessWidget {
  const DesktopAndTabletLayout({super.key, required this.body});

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: AppDrawer()),
          Expanded(flex: 5, child: body),
        ],
      ),
    );
  }
}
