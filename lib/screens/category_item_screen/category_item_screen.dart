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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [],
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
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}