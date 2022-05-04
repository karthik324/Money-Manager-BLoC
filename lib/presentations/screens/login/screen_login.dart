import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String finalName = '';
  final Box<UserName> userBox = Hive.box<UserName>(loginBox);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSpace(height: mediaQueryHeight * 0.08),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: mediaQueryHeight * 0.01),
                child: Image.asset(
                  'assets/images/undraw_Access_account_re_8spm.png',
                  width: mediaQueryWidth,
                  height: mediaQueryHeight * 0.4,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mediaQueryHeight * 0.03),
                  child: Text(
                    'Enter your name',
                    style: TextStyle(
                      fontSize: customFontSizeTitle,
                      fontWeight: bold,
                    ),
                  ),
                ),
                VerticalSpace(height: mediaQueryHeight * 0.01),
                Form(
                  key: formKey,
                  child: CustomInputField(
                    controller: nameController,
                    onChanged: (value) {
                      finalName = value;
                    },
                  ),
                ),
              ],
            ),
            VerticalSpace(height: mediaQueryHeight * 0.23),
            CustomElevatedButton(
              text: "Let's go",
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    nameController.text != '') {
                  UserName newUser = UserName(finalName);
                  userBox.add(newUser);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
