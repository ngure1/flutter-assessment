import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/app_drawer.dart';
import 'package:flutter_assessment/core/constants/constants.dart';

class DesktopAndTabletLayout extends StatelessWidget {
  const DesktopAndTabletLayout({super.key, required this.body});

  final Widget body;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: width < ScreenSize.desktop ? 2 : 1,
            child: AppDrawer(),
          ),
          Expanded(flex: 5, child: body),
        ],
      ),
    );
  }
}
