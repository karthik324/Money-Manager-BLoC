import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class CustomTextFieldExpense extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  CustomTextFieldExpense({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: mediaQueryWidth * 0.04,
        right: mediaQueryWidth * 0.04,
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty || value == '') {
            return 'Enter the amount';
          }
          return null;
        },
        onChanged: (val) {},
        cursorColor: redTheme,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            suffixIcon: FaIcon(
              FontAwesomeIcons.indianRupeeSign,
              color: redTheme,
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
