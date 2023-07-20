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
      height: 45,
      color: isEditable
          ? const Color.fromRGBO(255, 255, 255, 1)
          : Colors.transparent,
      child: TextField(
        autofocus: true,
        controller: titleController,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        // readOnly: !isEditable,
        // enabled: isEditable,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
