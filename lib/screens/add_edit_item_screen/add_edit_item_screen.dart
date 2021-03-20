import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/back_button.dart';
import 'package:budget_app_prelimm/global_widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
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
                'Update sample',
                style: kCategoryItemTitle.copyWith(
                  color: kColorBlack,
                ),
              ),
              content: Text(
                'Are you sure you want to update [item] from item list?',
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: darkMode == true
                    ? [kColorDarkModeBG, kColorDarkModeBG, kColorDarkModeBG]
                    : [kColorViolet1, kColorViolet1, kColorViolet2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 27,
              ),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButtonWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        widget.isEdit ? 'Edit Item' : 'Add Item',
                        style: ktitleHeader,
                      ),
                    ),
                    CustomInputField(
                      textController: itemNameTextController,
                      hintText: 'Add an item here',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Item name is required.';
                        }
                        return null;
                      },
                    ),
                    CustomInputField(
                      textController: itemAmountTextController,
                      keyboardType: TextInputType.name,
                      hintText: 'Add spent amount',
                      padding: EdgeInsets.symmetric(vertical: 15),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Spent amount is required.';
                        } else if (value is String) {
                          try {
                            print(value);
                            double spentAmount = double.parse(value);
                            print(widget.categoryLimit);

                            if (spentAmount > widget.categoryLimit) {
                              return 'Your desired amount is over the limit.';
                            } else {
                              return null;
                            }
                          } catch (err) {
                            print(err.toString());
                            return 'Spent amount only accepts number.';
                          }
                        }

                        return null;
                      },
                    ),
                    CustomInputField(
                      readOnly: true,
                      textController: dateSpentTextController,
                      hintText: 'Select date of spending',
                      prefixIcon: Icon(Icons.calendar_today),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Date of spending is required.';
                        }

                        return null;
                      },
                      onTap: () {},
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
}
