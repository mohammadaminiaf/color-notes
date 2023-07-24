import 'package:flutter/material.dart';

import '/auth/firestore_auth.dart';
import '/utils/utils.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.id,
  });

  final String id;

  Future deleteNote(BuildContext context) async {
    showDeleteDialog(context: context, text: 'Deleting the node...');
    await FirestoreAuth().deleteNote(id).then((isSuccess) {
      if (isSuccess) {
        // one to get out of the dialog
        Navigator.of(context).pop();
        // one to get pop the screen
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => deleteNote(context),
      icon: const Icon(Icons.delete),
    );
  }
}
