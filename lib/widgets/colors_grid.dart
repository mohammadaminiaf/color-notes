import 'package:flutter/material.dart';

import '/constansts/random_colors.dart';

class ColorsGrid extends StatelessWidget {
  const ColorsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250,
        width: 250,
        child: GridView.builder(
          itemCount: colors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pop(index);
              },
              child: Container(
                color: colors[index].headerColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
