import 'package:flutter/material.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/components/widgets/news_container/container_widget.dart';
import 'package:strongwave/core/global/routeName.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.valorantAllNews),
              child: ContainerWidget(
                title: "VALORANT NEWS",
                imagePath: 'assets/images/valoLogo.png',
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteNames.mmoNews),
              child: ContainerWidget(
                title: "MMO NEWS",
                imagePath: 'assets/images/mmoLogo.png',
              ),
            ),
            ContainerWidget(
              title: "COMING SOON...",
              imagePath: 'assets/images/askLogo.png',
            ),
          ],
        ),
      ),
    );
  }
}
