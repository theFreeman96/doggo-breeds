import 'package:doggo_breeds/data/fetch_random_from_collection.dart';
import 'package:flutter/material.dart';

import '/utilities/constants.dart';

import '/screens/images/images_grid.dart';
import '/screens/images/image_detail.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  bool isFromCollection = false;
  bool isByBreed = false;
  bool isBySubBreed = false;
  List<String>? images;

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateImages() async {
    if (isFromCollection == true) {
      final List<String>? imageString =
          await FetchRandomFromCollection().getRandomImages(6);
      setState(() {
        images = imageString;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: Image.asset(
                    'lib/assets/doggo_breeds_logo.png',
                    height: 100,
                  ),
                ),
                _buildButtonsColumn(),
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

  Widget _buildButtonsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.shuffle),
          label: const Text('From Collection'),
          onPressed: () {
            setState(() {
              isFromCollection = true;
              isByBreed = false;
              isBySubBreed = false;
            });
            updateImages();
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.pets),
          label: const Text('By Breed'),
          onPressed: () {
            setState(() {
              isFromCollection = false;
              isByBreed = true;
              isBySubBreed = false;
            });
            updateImages();
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.sell),
          label: const Text('By Sub-breed'),
          onPressed: () {
            setState(() {
              isFromCollection = false;
              isByBreed = false;
              isBySubBreed = true;
            });
            updateImages();
          },
        ),
      ],
    );
  }
}
