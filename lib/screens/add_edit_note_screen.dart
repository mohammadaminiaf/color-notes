import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '/auth/firestore_auth.dart';
import '/models/note.dart';
import '/models/note_color.dart';
import '/params/add_note_params.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({
    super.key,
    this.note,
    this.color,
  });

  final Note? note;
  final NoteColor? color;

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  // flags
  bool isEditable = true;

  // note properties
  String? id;
  String? posterId;
  DateTime? dateCreated;
  late final TextEditingController _titleController;
  late final TextEditingController _textController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _bodyFocusNode;

  void makeEditable() {
    setState(() => isEditable = true);
  }

  addUpdateNote() async {
    if (id == null && dateCreated == null) {
      id = const Uuid().v1();
      dateCreated = DateTime.now();
    }
    await FirestoreAuth().addUpdateNote(
      params: AddNoteParams(
        id: id,
        posterId: posterId,
        dateCreated: dateCreated,
        title: _titleController.text.trim(),
        text: _textController.text.trim(),
      ),
    );
  }

  Future deleteNote() async {
    await FirestoreAuth().deleteNote(id!).then((isSuccess) {
      if (isSuccess) Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _textController = TextEditingController();
    _titleFocusNode = FocusNode();
    _bodyFocusNode = FocusNode();

    // If we're updating a note
    if (widget.note != null && widget.color != null) {
      isEditable = false;
      _titleController.text = widget.note!.title;
      _textController.text = widget.note!.text;
      id = widget.note!.id;
      posterId = widget.note!.posterId;
      dateCreated = widget.note!.dateCreated;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FocusScope(
      child: Scaffold(
        appBar: AppBar(
          // title text field
          title: TitleTextField(
            onTap: () => FocusScope.of(context).requestFocus(_titleFocusNode),
            titleController: _titleController,
            titleFocusNode: _titleFocusNode,
            onDoubleTap: () {
              makeEditable();
            },
            onSubmitted: (_) {
              FocusScope.of(context).requestFocus(_bodyFocusNode);
            },
            isEditable: isEditable,
          ),
          backgroundColor: widget.color == null
              ? Colors.deepPurple
              : widget.color!.headerColor,
          actions: [
            id != null
                ? IconButton(
                    onPressed: deleteNote,
                    icon: const Icon(Icons.delete),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: () async {
                setState(() {
                  isEditable = false;
                });
                await addUpdateNote();
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          width: size.width,
          height: size.height,
          color: widget.color == null ? Colors.purple : widget.color!.bodyColor,
          child: GestureDetector(
            onTap: () {
              if (!isEditable) {
                Fluttertoast.showToast(msg: 'Double tap to edit the note');
              } else {
                FocusScope.of(context).requestFocus(_bodyFocusNode);
              }
            },
            onDoubleTap: () {
              makeEditable();
              FocusScope.of(context).requestFocus(_bodyFocusNode);
            },
            child: TextField(
              focusNode: _bodyFocusNode,
              controller: _textController,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              // enabled: isEnabled,
              maxLines: null,
              enabled: isEditable,
              readOnly: !isEditable,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.titleController,
    required this.titleFocusNode,
    required this.onSubmitted,
    required this.onDoubleTap,
    required this.isEditable,
    required this.onTap,
  });

  final TextEditingController titleController;
  final Function(String text)? onSubmitted;
  final VoidCallback onDoubleTap;
  final FocusNode titleFocusNode;
  final VoidCallback onTap;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // on double tap works fine
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        height: 45,
        color: isEditable
            ? const Color.fromRGBO(255, 255, 255, 1)
            : Colors.transparent,
        child: TextField(
          autofocus: true,
          focusNode: titleFocusNode,
          controller: titleController,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          readOnly: !isEditable,
          enabled: isEditable,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
