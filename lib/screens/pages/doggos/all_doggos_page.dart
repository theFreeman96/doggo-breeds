import 'package:flutter/material.dart';

import '/data/fetch_breed_list.dart';
import '/data/fetch_by_breed.dart';
import '/data/fetch_by_sub_breed.dart';

import '/utilities/constants.dart';

import 'breed_dropdown.dart';
import 'sub_breed_dropdown.dart';

import '/screens/images/images_grid.dart';
import '/screens/images/image_detail.dart';

class AllDoggosPage extends StatefulWidget {
  const AllDoggosPage({super.key});

  @override
  State<AllDoggosPage> createState() => _AllDoggosPageState();
}

class _AllDoggosPageState extends State<AllDoggosPage> {
  Future<List<String>?>? breedsFuture;
  String? selectedBreed;
  Future<List<String>?>? subBreedsFuture;
  String? selectedSubBreed;
  List<String>? images;

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
      final List<String>? imagesList = await FetchBySubBreed()
          .getAllImagesBySubBreed(
              selectedBreed!.toLowerCase(), selectedSubBreed!.toLowerCase());
      setState(() {
        images = imagesList;
      });
    } else if (selectedBreed != null) {
      final List<String>? imagesList = await FetchByBreed()
          .getAllImagesByBreed(selectedBreed!.toLowerCase());
      setState(() {
        images = imagesList;
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
                buildDropdownsColumn(),
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

  Widget buildDropdownsColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BreedDropdown(
            breedsFuture: breedsFuture,
            selectedBreed: selectedBreed,
            onChanged: (String? breed) {
              setState(() {
                selectedBreed = breed;
                selectedSubBreed = null;
                subBreedsFuture = null;
                images = null;
              });
              updateSubBreeds();
              updateImages();
            },
          ),
          if (subBreedsFuture != null && selectedBreed != null)
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: SubBreedDropdown(
                subBreedsFuture: subBreedsFuture,
                selectedSubBreed: selectedSubBreed,
                onChanged: (String? subBreed) {
                  setState(() {
                    selectedSubBreed = subBreed;
                  });
                  updateImages();
                },
              ),
            ),
        ],
      ),
    );
  }
}
