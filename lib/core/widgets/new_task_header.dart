import 'package:flutter/material.dart';
import 'package:to_do_app/core/widgets/grident_star.dart';

class AddNewTaskHeader extends StatelessWidget {
  const AddNewTaskHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Add New Task",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
        ),
        gridentIconStar(
          startColor: Colors.yellow.shade900,
          endColor: Colors.yellow.shade200,
          size: 50.0,
        )
      ],
    );
  }
}
