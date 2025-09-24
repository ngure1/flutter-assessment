import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/layout/desktop_and_tablet_layout.dart';
import 'package:flutter_assessment/core/layout/layout.dart';
import 'package:flutter_assessment/core/layout/mobile_layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {'/': (context) => const HomeWidget()},
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      DesktopAndTabletLayout: DesktopAndTabletLayout(body: Text("Hello world")),
      MobileLayout: MobileLayout(),
    );
  }
}
