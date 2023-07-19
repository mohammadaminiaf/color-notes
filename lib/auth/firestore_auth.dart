import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '/models/note.dart';
import '/params/add_note_params.dart';

class FirestoreAuth {
  Future addUpdateNote({
    required AddNoteParams params,
  }) async {
    // Create a note
    Note note = Note(
      id: params.id!,
      text: params.text.trim(),
      title: params.title.trim(),
      color: 'yellow',
      posterId: FirebaseAuth.instance.currentUser!.uid,
      dateCreated: params.dateCreated!,
      dateUpdated: DateTime.now(),
    );

    try {
      // Post the note to Firestore
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(params.id)
          .set(note.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Delete a note
  Future<bool> deleteNote(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notes').doc(id).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future addNote({
    required String title,
    required String text,
  }) async {
    // if we're adding a note
    final uid = const Uuid().v1();
    final posterId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();

    // Create a note
    Note note = Note(
      id: uid,
      text: text,
      title: title,
      color: 'yellow',
      posterId: posterId,
      dateCreated: now,
      dateUpdated: now,
    );

    try {
      // Post the note to Firestore
      FirebaseFirestore.instance.collection('notes').doc(uid).set(note.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateNote({
    required String id,
    required String text,
    required String title,
  }) async {
    // Note newNote = Note(
    //   id: oldNote.id,
    //   text: text,
    //   title: title,
    //   color: oldNote.color,
    //   posterId: oldNote.posterId,
    //   dateCreated: oldNote.dateCreated,
    //   dateUpdated: oldNote.dateUpdated,
    // );

    try {
      FirebaseFirestore.instance.collection('notes').doc(id).set(
        {
          'text': text,
          'title': title,
          'dateUpdated': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
