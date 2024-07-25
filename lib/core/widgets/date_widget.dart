import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  final TextEditingController controller;
  const DateWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.blue[200]),
              const SizedBox(width: 4),
              const Text(
                "Date",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 30),
              ),
            ).then(
              (value) => {
                if (value != null) controller.text = value.parseTimeToString(),
              },
            ),
            child: TextFormField(
              enabled: false,
              textAlign: TextAlign.center,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "this field can't be empty";
                }
                return null;
              },
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension DateParasing on DateTime {
  String parseTimeToString() {
    return "$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}";
  }
}
