import 'package:flutter/material.dart';

import '/models/note.dart';
import '/screens/add_edit_note_screen.dart';
import '/utils/utils.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = getRandomColor();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddEditNoteScreen(
              note: note,
              color: color,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.headerColor,
          borderRadius: BorderRadius.circular(25),
        ),
        width: size.width * 0.45,
        height: size.height * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              note.text,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
