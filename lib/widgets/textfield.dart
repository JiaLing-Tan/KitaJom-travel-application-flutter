import 'package:flutter/material.dart';
import 'package:kitajom/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: textInputType,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: titleGreen),
              borderRadius: BorderRadius.circular(20.0),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ),
      ),
    );
  }
}