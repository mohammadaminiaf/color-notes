import 'package:flutter/material.dart';

import '/constansts/random_colors.dart';
import '/widgets/colors_grid.dart';

class PickColorButton extends StatelessWidget {
  const PickColorButton({
    super.key,
    required this.onTap,
    required this.color,
  });

  final Function(int? index) onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // wait for result of dialog and get our color
        int index = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => const Dialog(
            child: ColorsGrid(),
          ),
        );
        // send index of the selected color back to our caller function
        onTap(index);
      },
      child: Container(
        width: 35,
        height: 35,
        color: color,
      ),
    );
  }
}
