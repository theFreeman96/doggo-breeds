import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchByBreed {
  Future<List<String>?> getAllImagesByBreed(breed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/images'),
    );

    if (response.statusCode == 200) {
      final imagesByBreedJson = jsonDecode(response.body)['message'];
      List<String> imagesByBreedList = [];

      imagesByBreedJson.forEach((image) {
        imagesByBreedList.add('$image');
      });

      return imagesByBreedList;
    } else {
      throw Exception('Failed to load breed images for $breed');
    }
  }

  Future<String?> getRandomImageByBreed(breed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/images/random'),
    );

    if (response.statusCode == 200) {
      final randomImageByBreedJson = jsonDecode(response.body)['message'];
      return randomImageByBreedJson;
    } else {
      throw Exception('Failed to load random breed image for $breed');
    }
  }

  Future<List<String>?> getRandomImagesByBreed(breed, number) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/images/random/$number'),
    );

    if (response.statusCode == 200) {
      final randomImagesByBreedJson = jsonDecode(response.body)['message'];
      List<String> randomImagesByBreedList = [];

      randomImagesByBreedJson.forEach((image) {
        randomImagesByBreedList.add('$image');
      });

      return randomImagesByBreedList;
    } else {
      throw Exception('Failed to load random breed images for $breed');
    }
  }
}
