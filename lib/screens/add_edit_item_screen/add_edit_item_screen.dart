import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEditItemScreen extends StatefulWidget {
  final int categoryId;
  final double categoryLimit;
  final bool isEdit;

  const AddEditItemScreen({
    Key key,
    this.categoryId,
    this.categoryLimit,
    this.isEdit = false,
  }) : super(key: key);

  @override
  _AddEditItemScreenState createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController itemNameTextController;
  TextEditingController itemAmountTextController;
  TextEditingController dateSpentTextController;

  DateTime lastSelectedDate;
  int itemId;

  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;
  bool darkMode = false;

  Future<void> submitOnPressed() async {
    if (formKey.currentState.validate()) {
      if (widget.isEdit) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Update',
                style: kCategoryItemTitle.copyWith(
                  color: kColorBlack,
                ),
              ),
              content: Text(
                'Are you sure you want to update [SampleItem] from item list?',
                style: kCategoryItemTitle.copyWith(
                  color: kColorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Update',
                    style: kSubText.copyWith(color: kColorViolet1),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Cancel', style: kSubText),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    itemNameTextController = TextEditingController();
    itemAmountTextController = TextEditingController();
    dateSpentTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 27,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Edit or Add Choice',
                      style: ktitleHeader,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
