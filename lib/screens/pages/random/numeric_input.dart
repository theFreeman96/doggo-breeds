import 'package:flutter/material.dart';

import '/utilities/constants.dart';

class NumericInput extends StatefulWidget {
  const NumericInput({super.key, required this.onInit, required this.onUpdate});

  final Function(NumericInputState state) onInit;
  final VoidCallback onUpdate;

  @override
  NumericInputState createState() => NumericInputState();
}

class NumericInputState extends State<NumericInput> {
  late TextEditingController controller;
  int minValue = 1;
  int defValue = 6;
  int maxValue = 50;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = defValue.toString();
    widget.onInit(this);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: kDefaultPadding * 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  validateInput(value);
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: kGrey,
                  ),
                  labelText: 'Number',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: kGrey,
              ),
              onPressed: () {
                incrementValue();
                widget.onUpdate();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.remove_circle,
                color: kGrey,
              ),
              onPressed: () {
                decrementValue();
                widget.onUpdate();
              },
            ),
          ],
        ),
      ),
    );
  }

  int getCurrentValue() {
    return int.parse(controller.text);
  }

  void validateInput(String value) {
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
