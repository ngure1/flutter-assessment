import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/app_drawer.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: AppDrawer(), body: body);
  }
}
