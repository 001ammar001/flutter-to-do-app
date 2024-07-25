import 'package:flutter/material.dart';
import 'package:to_do_app/core/widgets/bottom_sheet_item.dart';

class FlotingButton extends StatelessWidget {
  const FlotingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.6,
      child: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const PostAddWidget(),
          );
        },
      ),
    );
  }
}
