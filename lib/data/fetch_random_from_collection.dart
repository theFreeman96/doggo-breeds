import 'dart:convert';

import 'package:http/http.dart' as http;

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
}
