import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';

class BarGraphSection extends StatefulWidget {
  const BarGraphSection({
    Key key,
  }) : super(key: key);

  @override
  _BarGraphSectionState createState() => _BarGraphSectionState();
}

class _BarGraphSectionState extends State<BarGraphSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.32,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: BoxDecoration(
            color: kColorWhite.withOpacity(0.40),
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ],
    );
  }
}
