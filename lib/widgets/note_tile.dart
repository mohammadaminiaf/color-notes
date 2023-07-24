import 'package:color_notes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/constansts/random_colors.dart';
import '/models/note.dart';
import '/screens/add_edit_note_screen.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddEditNoteScreen(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: colors[note.colorIndex].headerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 1),
            Text(
              DateFormat('MMM dd, yyyy').format(note.dateUpdated),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
