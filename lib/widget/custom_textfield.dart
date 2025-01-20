import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String nama;
  final TextEditingController controller;
  final TextInputType? typekeyboard;
  const CustomTextfield(
      {super.key,
      required this.nama,
      required this.controller,
      this.typekeyboard});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: typekeyboard,
      controller: controller,
      decoration: InputDecoration(
        labelText: nama,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
