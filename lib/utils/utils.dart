import 'dart:math' as math show Random;

import '/constansts/random_colors.dart';
import '/models/note_color.dart';

NoteColor getRandomColor() {
  final max = colors.length;
  final randomNumber = math.Random().nextInt(max);

  return colors[randomNumber];
}
