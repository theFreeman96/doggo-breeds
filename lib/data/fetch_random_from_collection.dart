import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '/data/fetch_breed_list.dart';

class FetchRandomFromCollection {
  Future<String?> getRandomImage() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/image/random'),
    );

    if (response.statusCode == 200) {
      final randomImageJson = jsonDecode(response.body)['message'];
      return randomImageJson;
    } else {
      throw Exception('Failed to load random image');
    }
  }

  Future<List<String>?> getRandomImages(number) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/image/random/$number'),
    );

    if (response.statusCode == 200) {
      final randomImagesJson = jsonDecode(response.body)['message'];
      List<String> randomImagesList = [];

      randomImagesJson.forEach((image) {
        randomImagesList.add('$image');
      });

      return randomImagesList;
    } else {
      throw Exception('Failed to load random images');
    }
  }

  Future<String?> getRandomBreed() async {
    final breedList = await FetchBreedList().getAllBreeds();

    if (breedList!.isNotEmpty) {
      final randomBreed = breedList[Random().nextInt(breedList.length)];
      return randomBreed;
    } else {
      throw Exception('Failed to load random breed');
    }
  }

  Future<String?> getRandomSubBreed(randomBreed) async {
    if (randomBreed != null) {
      final response = await http.get(
        Uri.parse('https://dog.ceo/api/breed/$randomBreed/list'),
      );

      if (response.statusCode == 200) {
        final subBreedsJson = jsonDecode(response.body)['message'];

        if (subBreedsJson is List) {
          final subBreedsList = subBreedsJson.cast<String>();

          if (subBreedsList.isNotEmpty) {
            final randomSubBreed =
                subBreedsList[Random().nextInt(subBreedsList.length)];
            return randomSubBreed;
          }
        }
      }
    }
    return null;
  }
}
