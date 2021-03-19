import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String text;

  const EmptyPlaceholder({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 25),
        child: Text(
          text,
          style: kCategoryPriceText.copyWith(
            color: kColorWhite,
          ),
        ),
      ),
    );
  }
}
