import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          onPressed: () {
            print('Settings tapped!');
          },
          icon: Icon(
            Icons.add,
            size: 30,
            color: kColorViolet2,
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: kColorWhite.withOpacity(0.40),
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          onPressed: () {
            print('Settings tapped!');
          },
          icon: Icon(
            Icons.add,
            size: 30,
            color: kColorWhite,
          ),
        ),
      ),
    );
  }
}
