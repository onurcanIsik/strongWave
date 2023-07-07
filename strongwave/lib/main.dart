import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/view/navigator_page.dart';
import 'core/global/routeName.dart';

final _appRouter = RouteManager.getInstance();
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('passwordCard_box');
  runApp(
    MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 4,
      navigator: const NavigatorPage(),
      backgroundColor: bgColor,
      loaderColor: appBarColor,
      logo: Image.asset('assets/images/nobgDoodle.png'),
      loadingText: Text(
        'Loading...',
        style: GoogleFonts.amiko(color: Colors.grey),
      ),
    );
  }
}
