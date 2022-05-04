import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({Key? key}) : super(key: key);

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
              'assets/images/undraw_Pay_online_re_aqe6.png',
              width: mediaQueryWidth,
              height: mediaQueryHeight * 0.4,
            ),
          ),
          VerticalSpace(height: mediaQueryHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All your finance in one place',
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
                'See the bigger picture by having all your',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'finance in one place',
                style: TextStyle(fontWeight: bold),
              ),
            ],
          ),
          VerticalSpace(
            height: mediaQueryHeight * 0.26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: 'Skip',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
              CustomElevatedButton(
                text: 'Next',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen2(),
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
