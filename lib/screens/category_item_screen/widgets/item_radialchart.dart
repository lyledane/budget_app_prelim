import 'package:budget_app_prelimm/constants/style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    );
  }
}
