import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Feels so empty! add a Note!',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
