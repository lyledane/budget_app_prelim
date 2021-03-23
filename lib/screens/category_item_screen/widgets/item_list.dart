import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ItemList extends StatefulWidget {
  final double categoryLimit;

  const ItemList({
    Key key,
    this.categoryLimit,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;

  bool darkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.29,
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkMode == true ? kColorDarkModeSurface : kColorWhite,
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
                'Items',
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
