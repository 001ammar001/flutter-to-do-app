import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final int taskCount;
  const WelcomeHeader({
    super.key,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Will Hello!\n",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        children: [
          TextSpan(
            text: "we have $taskCount things on the list today",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
