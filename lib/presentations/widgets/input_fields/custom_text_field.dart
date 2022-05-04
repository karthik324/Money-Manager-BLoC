import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: mediaQueryWidth * 0.04, right: mediaQueryWidth * 0.04),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == '') {
            return 'Enter the amount';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: FaIcon(
              FontAwesomeIcons.indianRupeeSign,
              color: greenTheme,
              size: 20,
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}
