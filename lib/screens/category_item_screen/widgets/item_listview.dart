import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ItemListView extends StatefulWidget {
  final double categoryLimit;
  final PickerDateRange initialSelectedRange;

  const ItemListView({
    Key key,
    this.categoryLimit,
    this.initialSelectedRange,
  }) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(7),
        itemCount: 0,
        itemBuilder: (context, index) {
          return Slidable(
            key: Key('$index'),
            actionPane: SlidableDrawerActionPane(
              key: Key('$index'),
            ),
            actionExtentRatio: 0.25,
            secondaryActions: [],
            child: ListTile(
              title: Text(
                'title',
                style: kCategoryItemTitle,
              ),
              subtitle: Text(
                'subtitle',
                style: kSubText,
              ),
              trailing: Text('trailing'),
            ),
          );
        },
      ),
    );
  }
}
