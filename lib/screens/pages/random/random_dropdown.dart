import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class RandomDropdown extends StatelessWidget {
  final List filterList;
  final ValueChanged<String?>? onChanged;

  const RandomDropdown({
    super.key,
    required this.filterList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Row(
            children: [
              Text('Select a filter'),
            ],
          ),
        ),
        ...filterList.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ],
      onChanged: onChanged,
      hint: const Text('Select a filter'),
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
    );
  }
}
