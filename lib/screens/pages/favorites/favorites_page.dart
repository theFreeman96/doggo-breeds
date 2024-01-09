import 'package:flutter/material.dart';

import '/data/fetch_breed_list.dart';
import '/data/fetch_by_breed.dart';
import '/data/fetch_by_sub_breed.dart';

import '/utilities/constants.dart';

import '/screens/images/images_grid.dart';
import '/screens/images/image_detail.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<String>?>? breedsFuture;
  String? selectedBreed;
  Future<List<String>?>? subBreedsFuture;
  String? selectedSubBreed;
  List<String>? images;
  String? image;

  @override
  void initState() {
    super.initState();
    breedsFuture = FetchBreedList().getAllBreeds();
  }

  Future<void> updateSubBreeds() async {
    if (selectedBreed != null) {
      final List<String>? subBreedList =
          await FetchBySubBreed().getSubBreeds(selectedBreed!.toLowerCase());

      if (subBreedList != null && subBreedList.isNotEmpty) {
        setState(() {
          subBreedsFuture = Future.value(subBreedList);
        });
      }
    }
  }

  Future<void> updateImages() async {
    if (selectedSubBreed != null) {
      final String? imageString = await FetchBySubBreed()
          .getRandomImageBySubBreed(
              selectedBreed!.toLowerCase(), selectedSubBreed!.toLowerCase());
      setState(() {
        image = imageString;
      });
    } else if (selectedBreed != null) {
      final String? imageString = await FetchByBreed()
          .getRandomImageByBreed(selectedBreed!.toLowerCase());
      setState(() {
        image = imageString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: Image.asset(
                    'lib/assets/doggo_breeds_logo.png',
                    height: 100,
                  ),
                ),
                const Center(
                  child: Text(
                    'My Favorite\nDoggos',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                  ),
                ),
              ],
            ),
          ),
          ImagesGrid(
            images: images ?? [],
            onTap: (int index) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ImageDetail(
                      breed: selectedBreed!,
                      subBreed: selectedSubBreed,
                      initialIndex: index,
                      images: images!,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
