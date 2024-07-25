import 'package:flutter/material.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Calendar",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365 * 3)),
          lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
          onDateChanged: (value) {},
        )
      ],
    );
  }
}
