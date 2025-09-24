// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.desktopAndTabletLayout,
    required this.mobileLayout,
  });

  final Widget desktopAndTabletLayout;
  final Widget mobileLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        if (constaints.maxWidth >= ScreenSize.tablet) {
          return desktopAndTabletLayout;
        } else {
          return mobileLayout;
        }
      },
    );
  }
}
