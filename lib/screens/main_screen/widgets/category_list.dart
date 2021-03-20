import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key key,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Categories',
                style: kCategoryTitle.copyWith(
                  color: darkMode == true ? kColorWhite : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
