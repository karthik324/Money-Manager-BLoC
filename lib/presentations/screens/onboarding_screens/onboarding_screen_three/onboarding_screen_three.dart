import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

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
            'assets/images/undraw_Success_factors_re_ce93.png',
            height: mediaQueryHeight * 0.4,
            width: mediaQueryWidth,
          )),
          const VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Track your spending',
                style: TextStyle(
                  fontSize: customFontSizeHead,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          const VerticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''Keep track of your expenses manually''',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.275,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen4(),
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
