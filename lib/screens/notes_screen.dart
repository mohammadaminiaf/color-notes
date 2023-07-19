import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_notes/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/models/note.dart';
import '/screens/add_edit_note_screen.dart';
import '/widgets/empty.dart';
import '/widgets/loader.dart';
import '/widgets/note_tile.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(
                  name: 'Mohammad',
                  email: 'mohammadisniceandgood',
                  imageUrl: 'imageUrl',
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              GoogleSignIn().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('posterId',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }

            if (!snapshot.hasData) {
              return const Empty();
            }

            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                // get note data
                final noteData = snapshot.data!.docs[index];
                final note = Note.fromMap(noteData.data());
                return NoteTile(
                  note: note,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddEditNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
