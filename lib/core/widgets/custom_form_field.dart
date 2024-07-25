import 'package:flutter/material.dart';

TextFormField coustomFormField({
  required TextEditingController controller,
  String? text,
}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "this field can't be empty";
      }
      return null;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
      hintText: text,
    ),
  );
}
