import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class BreedDropdown extends StatelessWidget {
  final Future<List<String>?>? breedsFuture;
  final String? selectedBreed;
  final ValueChanged<String?>? onChanged;

  const BreedDropdown({
    Key? key,
    required this.breedsFuture,
    required this.selectedBreed,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: breedsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String>? breeds = snapshot.data;
          return DropdownButtonFormField<String>(
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Row(
                  children: [
                    Text('Select a breed'),
                  ],
                ),
              ),
              ...breeds!
                  .map((String breed) => DropdownMenuItem<String>(
                        value: breed,
                        child: Text(breed),
                      ))
                  .toList(),
            ],
            onChanged: onChanged,
            value: selectedBreed,
            hint: const Text('Select a breed'),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: kDefaultPadding,
              ),
              prefixIcon: Icon(
                Icons.pets,
                color: kGrey,
              ),
              labelText: 'Breed',
              alignLabelWithHint: true,
            ),
          );
        }
      },
    );
  }
}
