import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/widgets/item_list.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/widgets/item_radialchart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CategoryItemScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  final String categoryLimit;

  const CategoryItemScreen({
    Key key,
    this.categoryName,
    this.categoryId,
    this.categoryLimit,
  }) : super(key: key);

  @override
  _CategoryItemScreenState createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
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
    return Scaffold(
      backgroundColor: kColorTransparent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: darkMode == true
                  ? [kColorDarkModeBG, kColorDarkModeBG, kColorDarkModeBG]
                  : [kColorViolet1, kColorViolet1, kColorViolet2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      widget.categoryName,
                      style: kSubText.copyWith(
                        color: kColorWhite,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(height: 18),
                    ItemRadialChart(
                      categoryAmountLimit: widget.categoryLimit,
                      color: darkMode == true ? kColorWhite : kColorViolet1,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              ItemList(),
            ],
          ),
        ),
      ),
    );
  }
}
