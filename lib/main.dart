import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utilities/themes.dart';

import '/screens/home/home_page.dart';

void main() {
  runApp(const DoggoBreeds());
}

class DoggoBreeds extends StatelessWidget {
  const DoggoBreeds({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.def,
      home: const AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: HomePage(title: 'DoggoBreeds'),
      ),
    );
  }
}
