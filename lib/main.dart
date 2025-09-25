import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';
import 'package:flutter_assessment/core/screens/dashboard.dart';
import 'package:flutter_assessment/core/screens/gallery.dart';
import 'package:flutter_assessment/core/screens/profile.dart';
import 'package:flutter_assessment/features/images/dashboard/provider/dashboard_images_provider.dart';
import 'package:flutter_assessment/features/images/gallery/provider/gallery_search_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  // usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardImagesProvider()),
        ChangeNotifierProvider(create: (context) => GallerySearchProvider()),
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
