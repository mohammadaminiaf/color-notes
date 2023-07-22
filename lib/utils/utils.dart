import 'dart:math' as math show Random;

import 'package:flutter/material.dart';

import '/constansts/random_colors.dart';
import '/models/note_color.dart';

NoteColor getRandomColor() {
  final max = colors.length;
  final randomNumber = math.Random().nextInt(max);

  return colors[randomNumber];
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
