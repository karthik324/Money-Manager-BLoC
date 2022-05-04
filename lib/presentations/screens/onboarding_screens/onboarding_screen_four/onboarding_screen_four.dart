import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          VerticalSpace(height: mediaQueryHeight * 0.08),
          SafeArea(
            child: Image.asset(
              'assets/images/undraw_Key_points_re_u903.png',
              height: mediaQueryHeight * 0.4,
              width: mediaQueryWidth,
            ),
          ),
          const VerticalSpace(height: 15),
          Text(
            'Set Reminder',
            style: TextStyle(
              fontSize: customFontSizeHead,
              fontWeight: bold,
            ),
          ),
          const VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set reminder of your upcoming payments or',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'incomes',
                style: TextStyle(fontWeight: bold),
              )
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Get Started',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
