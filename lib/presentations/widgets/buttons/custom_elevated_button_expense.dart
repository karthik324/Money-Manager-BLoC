import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class CustomElevatedButtonExpense extends StatelessWidget {
  const CustomElevatedButtonExpense(
      {Key? key, required this.text, this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: redTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minimumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13),
          maximumSize: Size(mediaQueryHeight * 0.35, mediaQueryWidth * 0.13)),
    );
  }
}
