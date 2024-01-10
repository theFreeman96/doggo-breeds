import 'dart:convert';

import 'package:http/http.dart' as http;

import '/utilities/string_utils.dart';

class FetchBreedList {
  Future<List<String>?> getAllBreeds() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/list/all'),
    );

    if (response.statusCode == 200) {
      final breedsJson = jsonDecode(response.body)['message'];
      List<String> breedList = [];

      breedsJson.forEach((key, value) {
        String capitalizedBreed = capitalizeString(key, ' ');
        breedList.add(capitalizedBreed);
      });

      return breedList;
    } else {
      throw Exception('Failed to load breeds');
    }
  }
}
