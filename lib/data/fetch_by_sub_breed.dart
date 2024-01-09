import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchBySubBreed {
  Future<List<String>?> getSubBreeds(String breed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/list'),
    );

    if (response.statusCode == 200) {
      final subBreedsJson = jsonDecode(response.body)['message'];
      List<String> subBreedList = [];

      subBreedsJson.forEach((subBreed) {
        String capitalizedSubBreed = subBreed.split(' ').map((word) {
          return word[0].toUpperCase() + word.substring(1);
        }).join(' ');

        subBreedList.add(capitalizedSubBreed);
      });

      return subBreedList;
    } else {
      throw Exception('Failed to load sub-breeds for $breed');
    }
  }

  Future<List<String>?> getAllImagesBySubBreed(breed, subBreed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/$subBreed/images'),
    );

    if (response.statusCode == 200) {
      final imagesByBreedJson = jsonDecode(response.body)['message'];
      List<String> imagesByBreedList = [];

      imagesByBreedJson.forEach((image) {
        imagesByBreedList.add('$image');
      });

      return imagesByBreedList;
    } else {
      throw Exception('Failed to load sub-breed images for $breed, $subBreed');
    }
  }

  Future<String?> getRandomImageBySubBreed(breed, subBreed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/$subBreed/images/random'),
    );

    if (response.statusCode == 200) {
      final randomImageByBreedJson = jsonDecode(response.body)['message'];
      return randomImageByBreedJson;
    } else {
      throw Exception(
          'Failed to load random sub-breed image for $breed, $subBreed');
    }
  }

  Future<List<String>?> getRandomImagesBySubBreed(
      breed, subBreed, number) async {
    final response = await http.get(
      Uri.parse(
          'https://dog.ceo/api/breed/$breed/$subBreed/images/random/$number'),
    );

    if (response.statusCode == 200) {
      final randomImagesByBreedJson = jsonDecode(response.body)['message'];
      List<String> randomImagesByBreedList = [];

      randomImagesByBreedJson.forEach((image) {
        randomImagesByBreedList.add('$image');
      });

      return randomImagesByBreedList;
    } else {
      throw Exception(
          'Failed to load random breed images for $breed, $subBreed');
    }
  }
}
