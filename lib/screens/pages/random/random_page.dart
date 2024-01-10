import 'package:flutter/material.dart';

import '/data/fetch_random_from_collection.dart';
import '/data/fetch_by_breed.dart';
import '/data/fetch_by_sub_breed.dart';

import '/utilities/constants.dart';
import '/utilities/string_utils.dart';

import '/screens/images/images_grid.dart';
import '/screens/images/image_detail.dart';
import 'numeric_input.dart';
import 'random_dropdown.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final List filterList = [
    'All collection',
    'By breed',
    'By sub-breed',
  ];

  bool isFromCollection = false;
  bool isByBreed = false;
  bool isBySubBreed = false;

  String? randomBreed;
  String? randomSubBreed;
  List<String>? images;

  NumericInputState? numericInputState;

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateImages() async {
    int currentNumber = numericInputState?.getCurrentValue() ?? 6;
    randomBreed = await FetchRandomFromCollection().getRandomBreed();
    randomSubBreed = await FetchRandomFromCollection()
        .getRandomSubBreed(randomBreed!.toLowerCase());

    if (isFromCollection) {
      final List<String>? imageString =
          await FetchRandomFromCollection().getRandomImages(currentNumber);
      setState(() {
        images = imageString;
      });
    } else if (isByBreed) {
      final List<String>? imageString =
          await FetchByBreed().getRandomImagesByBreed(
        randomBreed!.toLowerCase(),
        currentNumber,
      );
      setState(() {
        images = imageString;
      });
    } else if (isBySubBreed) {
      final List<String>? imageString =
          await FetchBySubBreed().getRandomImagesBySubBreed(
        randomBreed!.toLowerCase(),
        randomSubBreed!.toLowerCase(),
        currentNumber,
      );
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
                Expanded(
                  child: Column(
                    children: [
                      RandomDropdown(
                          filterList: filterList,
                          onChanged: (value) {
                            setState(() {
                              randomBreed = null;
                              randomSubBreed = null;

                              if (value == filterList[0]) {
                                isFromCollection = true;
                                isByBreed = false;
                                isBySubBreed = false;
                              } else if (value == filterList[1]) {
                                isFromCollection = false;
                                isByBreed = true;
                                isBySubBreed = false;
                              } else if (value == filterList[2]) {
                                isFromCollection = false;
                                isByBreed = false;
                                isBySubBreed = true;
                              } else {
                                isFromCollection = false;
                                isByBreed = false;
                                isBySubBreed = false;
                                images = null;
                              }
                            });
                            updateImages();
                          }),
                      if (isFromCollection == true ||
                          isByBreed == true ||
                          isBySubBreed == true)
                        Padding(
                          padding: const EdgeInsets.only(top: kDefaultPadding),
                          child: NumericInput(
                            onUpdate: updateImages,
                            onInit: (state) {
                              numericInputState = state;
                            },
                          ),
                        ),
                    ],
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
                      breed: capitalizeString(
                        Uri.parse(
                          images![index],
                        ).pathSegments[1],
                        '-',
                      ),
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
