import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';

class ItemRadialChart extends StatelessWidget {
  final String categoryAmountLimit;
  final Color color;

  const ItemRadialChart({
    Key key,
    this.categoryAmountLimit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.40,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: kColorWhite.withOpacity(0.40),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
        ));
  }
}
