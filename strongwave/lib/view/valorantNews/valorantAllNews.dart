// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/view/valorantNews/valorant_agents.dart';
import 'package:strongwave/view/valorantNews/valorant_events.dart';

class ValorantAllNews extends StatefulWidget {
  const ValorantAllNews({super.key});

  @override
  State<ValorantAllNews> createState() => _ValorantAllNewsState();
}

class _ValorantAllNewsState extends State<ValorantAllNews>
    with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar(),
      body: _buildPage(),
    );
  }

  TabBarView _buildPage() {
    return TabBarView(
      controller: _tabController,
      children: const [
        ValorantEvents(),
        ValorantAgents(),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 10,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            controller: _tabController,
            indicatorWeight: 3,
            dividerColor: btmColor,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelColor: bgColor,
            labelStyle: GoogleFonts.comfortaa(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Valorant Events'),
              Tab(text: 'Valorant Agents'),
            ],
          ),
        ),
      ),
      backgroundColor: appBarColor,
      title: Text(
        'Valorant All News',
        style: GoogleFonts.balooDa2(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
