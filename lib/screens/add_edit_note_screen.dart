import 'package:color_notes/notebook.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/auth/firestore_auth.dart';
import '/constansts/random_colors.dart';
import '/models/note.dart';
import '/params/add_note_params.dart';
import '/widgets/delete_button.dart';
import '/widgets/pick_color_button.dart';
import '/widgets/title_text_field.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  // flags
  bool isEditable = true;

  // note properties
  String? id;
  String? posterId;
  int colorIndex = 6;
  DateTime? dateCreated;
  late final TextEditingController _titleController;
  late final TextEditingController _textController;
  late final FocusNode _bodyFocusNode;

  void makeEditable() {
    setState(() => isEditable = true);
  }

  addUpdateNote() async {
    // if we're adding a task
    if (id == null && dateCreated == null) {
      id = const Uuid().v1();
      dateCreated = DateTime.now();
    }
    // save data to firestore
    await FirestoreAuth().addUpdateNote(
      params: AddNoteParams(
        id: id,
        posterId: posterId,
        dateCreated: dateCreated,
        title: _titleController.text.trim(),
        text: _textController.text.trim(),
        colorIndex: colorIndex,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _textController = TextEditingController();
    _bodyFocusNode = FocusNode();

    // If we're updating a note
    if (widget.note != null) {
      isEditable = false;
      _titleController.text = widget.note!.title;
      _textController.text = widget.note!.text;
      id = widget.note!.id;
      posterId = widget.note!.posterId;
      dateCreated = widget.note!.dateCreated;
      colorIndex = widget.note!.colorIndex;
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
    return Scaffold(
      appBar: AppBar(
        // title text field
        title: TitleTextField(
          onSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_bodyFocusNode),
          titleController: _titleController,
          isEditable: isEditable,
        ),
        backgroundColor: colors[colorIndex].headerColor,
        actions: [
          isEditable
              ? Row(
                  children: [
                    // pick color button
                    PickColorButton(
                      onTap: (int? index) {
                        if (index != null) {
                          colorIndex = index;
                          setState(() {});
                        }
                      },
                      color: colors[colorIndex].bodyColor,
                    ),

                    // save button
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
                )
              : Row(
                  children: [
                    // delete button
                    id != null
                        ? DeleteButton(
                            id: id!,
                          )
                        : const SizedBox.shrink(),

                    // edit button
                    IconButton(
                      onPressed: () {
                        makeEditable();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
        ],
      ),
      body: Notebook(
        color: colors[colorIndex].bodyColor,
        autoFocus: true,
        readOnly: !isEditable,
        focusNode: _bodyFocusNode,
        controller: _textController,
      ),
      // body: Container(
      //   padding: const EdgeInsets.all(8.0),
      //   width: size.width,
      //   height: size.height,
      //   color: colors[colorIndex].bodyColor,
      //   child: TextField(
      //     autofocus: true,
      //     readOnly: !isEditable,
      //     focusNode: _bodyFocusNode,
      //     controller: _textController,
      //     style: const TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.black,
      //     ),
      //     maxLines: null,
      //     keyboardType: TextInputType.multiline,
      //     decoration: const InputDecoration(
      //       border: InputBorder.none,
      //     ),
      //   ),
      // ),
    );
  }
}
