import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/model/password_model.dart';
import 'package:strongwave/view/homepage.dart';
import 'package:strongwave/view/news_page.dart';
import 'package:strongwave/view/password_create.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int selectedPage = 1;
  final pages = [
    const HomePage(),
    ChangeNotifierProvider(
      create: (context) => PasswordModel(),
      child: const PasswordCreator(),
    ),
    const NewsPage(),
  ];

  void indexPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      bottomNavigationBar: bottomNavBar(),
      body: pages[selectedPage],
    );
  }

  DotNavigationBar bottomNavBar() {
    return DotNavigationBar(
      selectedItemColor: bgColor,
      backgroundColor: btmBarColor,
      onTap: indexPage,
      currentIndex: selectedPage,
      items: [
        DotNavigationBarItem(
          icon: const Icon(Iconsax.home_1),
        ),
        DotNavigationBarItem(
          icon: const Icon(Iconsax.lock),
        ),
        DotNavigationBarItem(
          icon: const Icon(Iconsax.book_square),
        ),
      ],
    );
  }
}
