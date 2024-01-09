import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class NumericInput extends StatefulWidget {
  const NumericInput({super.key});

  @override
  NumericInputState createState() => NumericInputState();
}

class NumericInputState extends State<NumericInput> {
  late TextEditingController controller;
  int minValue = 1;
  int maxValue = 50;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = minValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: kDefaultPadding * 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                decrementValue();
              },
            ),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _validateInput(value);
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: kGrey,
                  ),
                  labelText: 'How much?',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                incrementValue();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _validateInput(String value) {
    try {
      int intValue = int.parse(value);

      if (intValue < minValue) {
        controller.text = minValue.toString();
      } else if (intValue > maxValue) {
        controller.text = maxValue.toString();
      }
    } catch (e) {
      // Ignore non-numeric input
    }
  }

  void incrementValue() {
    int currentValue = int.parse(controller.text);
    if (currentValue < maxValue) {
      controller.text = (currentValue + 1).toString();
    }
  }

  void decrementValue() {
    int currentValue = int.parse(controller.text);
    if (currentValue > minValue) {
      controller.text = (currentValue - 1).toString();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
