import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class CustomSubHead extends StatelessWidget {
  final String text;
  const CustomSubHead({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: mediaQueryHeight * 0.01,
              left: mediaQueryWidth * 0.04,
              right: mediaQueryWidth * 0.04),
          child: Text(
            text,
            style: TextStyle(fontSize: customFontSizeTitle, fontWeight: bold),
          ),
        ),
      ],
    );
  }
}
