import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      colorIndex: params.colorIndex,
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

  // Get all notes
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllNotes() {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('posterId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy('dateUpdated', descending: true)
        .snapshots();
  }

  // Get user from firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future addNote({
    required String text,
    required String title,
    required int colorIndex,
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
      dateCreated: now,
      dateUpdated: now,
      posterId: posterId,
      colorIndex: colorIndex,
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
