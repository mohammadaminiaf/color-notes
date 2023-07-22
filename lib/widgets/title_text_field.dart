import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.titleController,
    required this.onSubmitted,
    required this.isEditable,
  });

  final TextEditingController titleController;
  final Function(String text)? onSubmitted;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(
      //   left: 5,
      //   right: 5,
      // ),
      height: 45,
      color: isEditable
          ? const Color.fromRGBO(255, 255, 255, 1)
          : Colors.transparent,
      child: TextField(
        readOnly: !isEditable,
        controller: titleController,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
