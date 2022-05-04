import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

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
              'assets/images/undraw_Mobile_pay_re_sjb8.png',
              height: mediaQueryHeight * 0.4,
              width: mediaQueryWidth,
            ),
          ),
          const VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Know where your money',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'goes',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          const VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''With categories and more''',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          SizedBox(
            height: mediaQueryHeight * 0.23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen3(),
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
