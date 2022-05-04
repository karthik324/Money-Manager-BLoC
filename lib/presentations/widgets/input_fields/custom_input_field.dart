import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomInputField({Key? key, this.controller, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryHeight * 0.02, right: mediaQueryHeight * 0.02),
      child: TextFormField(
          textCapitalization: TextCapitalization.words,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              filled: true,
              fillColor: const Color.fromARGB(255, 241, 241, 241),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^[a-zA-Z][a-z A-Z]+$').hasMatch(value)) {
              return "Enter correct name";
            }
            return null;
          }),
    );
  }
}
