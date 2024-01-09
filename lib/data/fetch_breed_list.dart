import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchBreedList {
  Future<List<String>?> getAllBreeds() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/list/all'),
    );

    if (response.statusCode == 200) {
      final breedsJson = jsonDecode(response.body)['message'];
      List<String> breedList = [];

      breedsJson.forEach((key, value) {
        String capitalizedBreed = key.split(' ').map((word) {
          return word[0].toUpperCase() + word.substring(1);
        }).join(' ');

        breedList.add(capitalizedBreed);
      });

      return breedList;
    } else {
      throw Exception('Failed to load breeds');
    }
  }
}
