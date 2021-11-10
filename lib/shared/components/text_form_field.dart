import 'package:flutter/material.dart';

Widget myTextFromField({
  TextEditingController? controller,
  TextInputType? type,
  dynamic onSubmit,
  bool scurePassword = false,
  String? hint,
  dynamic validator,
  IconData? prefixIcon,
  IconData? suffixIcon,
  dynamic suffixPressed,
  TextInputAction? textInputAction,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: scurePassword,
    onFieldSubmitted: onSubmit,
    validator: validator,
    textInputAction: textInputAction,
    style: const TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.white,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          suffixIcon,
          color: Colors.white,
        ),
        onPressed: suffixPressed,
      ),
    ),
    cursorColor: Colors.white,
  );
}
