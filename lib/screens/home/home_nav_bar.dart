import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onTabTapped;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 0.0,
      selectedIndex: currentIndex,
      onDestinationSelected: onTabTapped,
      indicatorColor: kPrimaryColor.withOpacity(0.3),
      backgroundColor: kPrimaryColor.withOpacity(0.1),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.pets_outlined),
          selectedIcon: Icon(Icons.pets),
          label: 'All Doggos',
          tooltip: 'All Doggos',
        ),
        NavigationDestination(
          icon: Icon(Icons.shuffle_outlined),
          selectedIcon: Icon(Icons.shuffle),
          label: 'Random',
          tooltip: 'Random',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: 'Favorites',
          tooltip: 'Favorites',
        )
      ],
    );
  }
}
