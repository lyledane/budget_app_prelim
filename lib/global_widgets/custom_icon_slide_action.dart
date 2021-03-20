import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomIconSlideAction extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final Color color;
  final IconData icon;

  const CustomIconSlideAction({
    Key key,
    this.onTap,
    this.buttonText,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
      onTap: onTap,
      color: color,
      iconWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kColorWhite,
          ),
          Text(
            buttonText,
            style: kSubText.copyWith(
              color: kColorWhite,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
