import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/app_drawer.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app bar", style: TextStyle(fontSize: 14))),
      drawer: AppDrawer(),
      body: Center(child: Text("Mobile Layout")),
    );
  }
}
