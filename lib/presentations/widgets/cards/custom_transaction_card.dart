import 'package:flutter/material.dart';

class CustomTransactionCard extends StatelessWidget {
  final String date;
  final String category;
  final String amount;
  final Color color;
  const CustomTransactionCard({
    Key? key,
    required this.amount,
    required this.category,
    required this.color,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.maxFinite,
      height: mediaQueryHeight * 0.1,
      child: Card(
        child: Center(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), //or 15.0
              child: Container(
                height: mediaQueryHeight * 0.7,
                width: mediaQueryWidth * 0.32,
                color: color,
                child: Center(
                  child: Text(
                    date,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(category),
            trailing: Text(
              amount,
              style: TextStyle(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
