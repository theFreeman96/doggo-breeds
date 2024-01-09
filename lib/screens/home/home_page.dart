import 'package:flutter/material.dart';

import 'home_nav_bar.dart';

import '/screens/pages/doggos/all_doggos_page.dart';
import '/screens/pages/random/random_page.dart';
import '/screens/pages/favorites/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> pageBodies = const [
    AllDoggosPage(),
    RandomPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: pageBodies[currentIndex],
      bottomNavigationBar: HomeNavBar(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
