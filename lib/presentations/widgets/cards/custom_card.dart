import 'package:flutter/material.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class CustomCard extends StatelessWidget {
  final String circleAvatarText;
  final String dueDate;
  final String title;
  final int payMent;
  const CustomCard({
    Key? key,
    required this.circleAvatarText,
    required this.title,
    required this.dueDate,
    required this.payMent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: mediaQueryWidth * 0.045, top: mediaQueryHeight * 0.01),
            child: Row(
              children: [
                Text(
                  'Upcoming Payments',
                  style: TextStyle(
                      fontSize: customFontSizeTitle, fontWeight: bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: redTheme,
              radius: 20,
              child: Text(
                circleAvatarText,
                style:
                    const TextStyle(fontFamily: 'Prompt', color: Colors.white),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: customFontSizePara, fontWeight: bold),
            ),
            subtitle: Text(
              'Due date - $dueDate',
              style: TextStyle(
                  fontSize: 11, fontWeight: bold, color: Colors.black),
            ),
            trailing: Text(
              '₹$payMent',
              style: TextStyle(color: redTheme),
            ),
          ),
        ],
      ),
    );
  }
}
