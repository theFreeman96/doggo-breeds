import 'package:flutter/material.dart';

import '/data/fetch_random_from_collection.dart';

import '/utilities/constants.dart';
import '/utilities/string_utils.dart';

import '/screens/images/images_grid.dart';
import '/screens/images/image_detail.dart';
import 'numeric_input.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  late String filterHint;
  final List filterList = [
    'No filter',
    'By breed',
    'By sub-breed',
  ];

  bool isFromCollection = false;
  bool isByBreed = false;
  bool isBySubBreed = false;
  List<String>? images;

  @override
  void initState() {
    filterHint = 'No filter';
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
                Expanded(
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        items:
                            filterList.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            isFromCollection = true;
                            isByBreed = false;
                            isBySubBreed = false;
                          });
                          updateImages();
                        },
                        hint: Text(filterHint),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          prefixIcon: Icon(
                            Icons.filter_list_alt,
                            color: kGrey,
                          ),
                          labelText: 'Random filter',
                          alignLabelWithHint: true,
                        ),
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: kDefaultPadding),
                        child: NumericInput(),
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
