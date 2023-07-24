// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Notebook extends StatelessWidget {
  const Notebook({
    Key? key,
    required this.color,
    required this.autoFocus,
    required this.readOnly,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final Color color;
  final bool autoFocus;
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const SizedBox(height: 15.0),
            CustomPaint(
              painter: NotebookPagePainter(),
              child: SingleChildScrollView(
                child: Padding(
                  // height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 5, left: 12, right: 12),
                  child: CustomTextField(
                    autoFocus: autoFocus,
                    controller: controller,
                    focusNode: focusNode,
                    readOnly: readOnly,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class NotebookPagePainter extends CustomPainter {
  final linePaint = Paint()
    ..color = Colors.black87
    ..strokeWidth = 1.0;

  final linePaint2 = Paint()
    ..color = Colors.transparent
    ..strokeWidth = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    const lineSpacing = 30.0; // Adjust the line spacing as needed
    final linesCount = ((size.height + 22) ~/ lineSpacing) + 100;

    for (int i = 0; i < linesCount; i++) {
      final y = i * lineSpacing;
      if (i != 0) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    required this.autoFocus,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      controller: controller,
      readOnly: readOnly,
      focusNode: focusNode,
      maxLines: null,
      textAlignVertical: TextAlignVertical.top,
      style: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        height: 1.2, // Adjust the height for line spacing
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero, // Remove default padding
      ),
    );
  }
}
