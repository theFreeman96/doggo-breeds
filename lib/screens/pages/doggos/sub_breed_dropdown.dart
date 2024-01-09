import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class SubBreedDropdown extends StatelessWidget {
  final Future<List<String>?>? subBreedsFuture;
  final String? selectedSubBreed;
  final ValueChanged<String?>? onChanged;

  const SubBreedDropdown({
    Key? key,
    required this.subBreedsFuture,
    required this.selectedSubBreed,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>?>(
      future: subBreedsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String>? subBreeds = snapshot.data;
          return DropdownButtonFormField<String>(
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All sub-breeds'),
              ),
              ...subBreeds!
                  .map((String subBreed) => DropdownMenuItem<String>(
                        value: subBreed,
                        child: Text(subBreed),
                      ))
                  .toList(),
            ],
            onChanged: onChanged,
            value: selectedSubBreed,
            hint: const Text('All sub-breeds'),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: kDefaultPadding,
              ),
              prefixIcon: Icon(
                Icons.sell,
                color: kGrey,
              ),
              labelText: 'Sub-Breed',
              alignLabelWithHint: true,
            ),
          );
        }
      },
    );
  }
}
