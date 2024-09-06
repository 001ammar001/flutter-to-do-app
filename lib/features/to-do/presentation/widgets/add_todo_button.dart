import 'package:flutter/material.dart';
import 'package:to_do_app/core/widgets/bottom_sheet_item.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      hoverColor: Colors.amber,
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const AddTodoBottomSheet(),
        );
      },
    );
  }
}
