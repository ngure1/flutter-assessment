// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required this.DesktopAndTabletLayout, required this.MobileLayout});

  final Widget DesktopAndTabletLayout;
  final Widget MobileLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constaints) {
        if (constaints.maxWidth >= ScreenSize.tablet) {
          return DesktopAndTabletLayout;
        } else {
          return  MobileLayout;
        }
      },
    );
  }
}
