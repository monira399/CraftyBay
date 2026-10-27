
import 'package:flutter/material.dart';

class AddressField extends StatelessWidget {
  const AddressField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }

    if (label == 'Phone Number') {
      final phone = value.trim();

      if (!RegExp(r'^(?:\+?88)?01[3-9]\d{8}$')
          .hasMatch(phone)) {
        return 'Enter a valid Bangladeshi phone number';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: _validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF7F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorMaxLines: 2,
      ),
    );
  }
}
