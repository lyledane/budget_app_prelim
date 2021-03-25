import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/current_amount_cubit/current_amount_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/bloc/item_bloc/item_bloc.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/back_button.dart';
import 'package:budget_app_prelimm/global_widgets/custom_input_field.dart';
import 'package:budget_app_prelimm/global_widgets/custom_submit_button.dart';
import 'package:budget_app_prelimm/models/item.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEditItemScreen extends StatefulWidget {
  final DatabaseService databaseService;
  final int categoryId;
  final double categoryLimit;
  final bool isEdit;
  final Item item;

  const AddEditItemScreen({
    Key key,
    this.databaseService,
    this.categoryId,
    this.categoryLimit,
    this.isEdit = false,
    this.item,
  }) : super(key: key);

  @override
  _AddEditItemScreenState createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final TextFormatter textFormatter = TextFormatter();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController itemNameTextController;
  TextEditingController itemAmountTextController;
  TextEditingController dateSpentTextController;

  DateTime lastSelectedDate;
  int itemId;

  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;

  static const Pattern pattern = r'^[a-zA-Z\s]*$';
  RegExp regex = RegExp(pattern);

  bool darkMode = false;

  Future<void> submitOnPressed() async {
    if (formKey.currentState.validate()) {
      if (widget.isEdit) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Update ${widget.item.itemName}',
                style: kCategoryItemTitle.copyWith(
                  color: kColorBlack,
                ),
              ),
              content: Text(
                'Are you sure you want to update ${widget.item.itemName} from item list?',
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

                    BlocProvider.of<ItemBloc>(context).add(
                      UpdateItemEvent(
                        databaseService: widget.databaseService,
                        itemId: itemId,
                        categoryId: widget.categoryId,
                        itemName: itemNameTextController.text,
                        itemAmount: double.parse(
                          itemAmountTextController.text,
                        ),
                        dateSpent: lastSelectedDate.toString(),
                        startDate: initialSelectedRange.startDate.toString(),
                        endDate: initialSelectedRange.endDate.toString(),
                      ),
                    );
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
      } else {
        BlocProvider.of<ItemBloc>(context).add(
          AddItemEvent(
            databaseService: widget.databaseService,
            categoryId: widget.categoryId,
            itemName: itemNameTextController.text,
            itemAmount: double.parse(
              itemAmountTextController.text,
            ),
            dateSpent: lastSelectedDate.toString(),
            startDate: initialSelectedRange.startDate.toString(),
            endDate: initialSelectedRange.endDate.toString(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    itemNameTextController = TextEditingController();
    itemAmountTextController = TextEditingController();
    dateSpentTextController = TextEditingController();

    if (widget.isEdit) {
      itemNameTextController = TextEditingController(
        text: widget.item.itemName,
      );

      itemAmountTextController = TextEditingController(
        text: textFormatter.removeMoneyFormatString(
          widget.item.itemAmount.toString(),
        ),
      );

      dateSpentTextController = TextEditingController(
        text: textFormatter.parseDate(
          dateFromDB: widget.item.dateSpent,
          fromDatabase: true,
        ),
      );

      itemId = widget.item.id;
      lastSelectedDate = DateTime.parse(widget.item.dateSpent);
    }

    var srs = BlocProvider.of<SelectedRangeCubit>(context).state;
    if (srs is SelectedRangeSaved) {
      startDate = DateTime.parse(srs.startDate);
      endDate = DateTime.parse(srs.endDate);

      initialSelectedRange = PickerDateRange(startDate, endDate);
    }

    var dm = BlocProvider.of<DarkModeCubit>(context).state;
    if (dm is DarkModeSuccess) {
      darkMode = dm.isDarkModeEnabled;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemSuccess) {
            Navigator.of(context).pop();

            double currentAmount = 0;
            state.items.forEach((element) {
              currentAmount = currentAmount + element.itemAmount;
            });

            BlocProvider.of<CurrentAmountCubit>(context).storeCurrentAmount(
              currentAmount,
            );

            BlocProvider.of<CategoryBloc>(context).add(
              GetCategoriesEvent(
                databaseService: widget.databaseService,
                startDate: initialSelectedRange.startDate.toString(),
                endDate: initialSelectedRange.endDate.toString(),
              ),
            );

            BlocProvider.of<BarGraphCubit>(context).getBarGraphData(
              databaseService: widget.databaseService,
              startDate: initialSelectedRange.startDate.toString(),
              endDate: initialSelectedRange.endDate.toString(),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                            } else if (value is String) {
                              try {
                                if (!regex.hasMatch(value)) {
                                  return 'Item name only accepts letters.';
                                } else {
                                  double.parse(value);
                                  return 'Item name only accepts letters.';
                                }
                              } catch (err) {
                                return null;
                              }
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
                          onTap: () async {
                            DateTime dateSpent = await showDatePicker(
                              context: context,
                              initialDate: widget.isEdit
                                  ? DateTime.parse(widget.item.dateSpent)
                                  : DateTime.now(),
                              firstDate: DateTime(1800, 1, 1),
                              lastDate: DateTime.now(),
                            );

                            if (dateSpent != null) {
                              lastSelectedDate = dateSpent;

                              dateSpentTextController = TextEditingController(
                                text: textFormatter.parseDate(
                                  date: lastSelectedDate,
                                  fromDatabase: false,
                                ),
                              );

                              if (mounted) setState(() {});
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        CustomSubmitButton(
                          color: darkMode == true ? kColorTeal : kColorViolet1,
                          onPressed: (state is! ItemLoading)
                              ? () async => await submitOnPressed()
                              : null,
                          child: (state is ItemLoading)
                              ? CircularProgressIndicator()
                              : Text(
                                  widget.isEdit ? 'Update' : 'Submit',
                                  style: kCategoryTitle.copyWith(
                                    color: kColorWhite,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
