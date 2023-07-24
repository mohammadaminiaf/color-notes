import 'dart:math' as math show Random;

import 'package:flutter/material.dart';

import '/constansts/random_colors.dart';
import '/constansts/random_sizes.dart';
import '/models/note_color.dart';

NoteColor getRandomColor() {
  final max = colors.length;
  final randomNumber = math.Random().nextInt(max);

  return colors[randomNumber];
}

double getRandomSize() {
  final max = randomSizes.length;
  final randomNumber = math.Random().nextInt(max);

  return randomSizes[randomNumber];
}

String getColorNameByIndex(int index) {
  switch (index) {
    case 0:
      return 'red';
    case 1:
      return 'orange';
    case 2:
      return 'green';
    case 3:
      return 'blue';
    case 4:
      return 'purple';
    case 5:
      return 'grey';
    case 6:
      return 'yellow';
    default:
      return 'yellow';
  }
}

NoteColor getColorByName(String colorName) {
  switch (colorName) {
    case 'red':
      return colors[0];
    case 'orange':
      return colors[1];
    case 'green':
      return colors[2];
    case 'blue':
      return colors[3];
    case 'purple':
      return colors[4];
    case 'grey':
      return colors[5];
    case 'yellow':
      return colors[6];
    default:
      return colors[6];
  }
}

Future<bool?> showDeleteDialog({
  required BuildContext context,
  required String text,
}) async {
  return showDialog<bool?>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.black54,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
