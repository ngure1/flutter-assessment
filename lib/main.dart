import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';
import 'package:flutter_assessment/core/screens/dashboard.dart';
import 'package:flutter_assessment/core/screens/gallery.dart';
import 'package:flutter_assessment/core/screens/profile.dart';
import 'package:flutter_assessment/features/dashboard/provider/dashboard_images_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  // usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardImagesProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: Urls.dashboard,
      routes: {
        Urls.dashboard: (context) => const DashboardPage(),
        Urls.gallery: (context) => const GalleryPage(),
        Urls.profile: (context) => const ProfilePage(),
      },
    );
  }
}
