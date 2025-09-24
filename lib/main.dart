import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/screens/dashboard.dart';
import 'package:flutter_assessment/core/screens/gallery.dart';
import 'package:flutter_assessment/core/screens/profile.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const DashboardPage(),
        "/gallery": (context) => const GalleryPage(),
        "/profile": (context) => const ProfilePage(),
      },
    );
  }
}
