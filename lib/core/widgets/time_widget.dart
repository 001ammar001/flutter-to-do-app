import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  final TextEditingController hoursController;
  final TextEditingController minutesController;
  const TimeWidget({
    super.key,
    required this.hoursController,
    required this.minutesController,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.watch_later_outlined, color: Colors.blue[200]),
              const SizedBox(width: 4),
              const Text(
                "Time",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then(
              (value) {
                if (value != null) {
                  hoursController.text =
                      value.parseTimeToString().substring(0, 2);
                  minutesController.text =
                      value.parseTimeToString().substring(3);
                }
              },
            ),
            child: Row(
              children: [
                _TimeField(controller: hoursController),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                _TimeField(controller: minutesController)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
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
        enabled: false,
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
    );
  }
}

extension To24HourString on TimeOfDay {
  String parseTimeToString() {
    return "${hour.toString().padLeft(2, "0")}-${minute.toString().padLeft(2, "0")}";
  }
}
