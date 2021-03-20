import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function addOnPressed;

  const AddButton({
    Key key,
    @required this.addOnPressed,
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
          onPressed: addOnPressed,
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
