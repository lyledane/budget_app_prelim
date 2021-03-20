import 'package:budget_app_prelimm/constants/style.dart';

import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
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
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: kColorWhite,
          ),
        ),
      ),
    );
  }
}
