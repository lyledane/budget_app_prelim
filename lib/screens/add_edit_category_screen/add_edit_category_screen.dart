import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/back_button.dart';
import 'package:budget_app_prelimm/global_widgets/custom_input_field.dart';
import 'package:budget_app_prelimm/global_widgets/custom_submit_button.dart';
import 'package:budget_app_prelimm/models/category.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final DatabaseService databaseService;
  final bool isEdit;
  final Category category;

  const AddEditCategoryScreen({
    Key key,
    this.databaseService,
    this.isEdit = false,
    this.category,
  }) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextFormatter textFormatter = TextFormatter();

  TextEditingController categoryNameTextController;
  TextEditingController categoryLimitTextController;
  int categoryId;

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
                'Update ${widget.category.categoryName}',
                style: kCategoryItemTitle.copyWith(
                  color: kColorBlack,
                ),
              ),
              content: Text(
                'Are you sure you want to update ${widget.category.categoryName} from category list?',
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

                    BlocProvider.of<CategoryBloc>(context).add(
                      UpdateCategoryEvent(
                        databaseService: widget.databaseService,
                        categoryId: widget.category.id,
                        categoryName: categoryNameTextController.value.text,
                        limit: double.parse(
                          categoryLimitTextController.value.text,
                        ),
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
        BlocProvider.of<CategoryBloc>(context).add(
          AddCategoryEvent(
            databaseService: widget.databaseService,
            categoryName: categoryNameTextController.value.text,
            limit: double.parse(
              categoryLimitTextController.value.text,
            ),
            startDate: initialSelectedRange.startDate.toString(),
            endDate: initialSelectedRange.endDate.toString(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    categoryNameTextController = TextEditingController();
    categoryLimitTextController = TextEditingController();

    if (widget.isEdit) {
      categoryId = widget.category.id;
      categoryNameTextController = TextEditingController(
        text: widget.category.categoryName,
      );
      categoryLimitTextController = TextEditingController(
        text: textFormatter.removeMoneyFormatString(
          widget.category.categoryLimit.toString(),
        ),
      );
    }

    var srs = BlocProvider.of<SelectedRangeCubit>(context).state;
    if (srs is SelectedRangeSaved) {
      startDate = DateTime.parse(srs.startDate);
      endDate = DateTime.parse(srs.endDate);

      initialSelectedRange = PickerDateRange(startDate, endDate);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkModeCubit, DarkModeState>(
      builder: (context, state) {
        if (state is DarkModeSuccess) {
          darkMode = state.isDarkModeEnabled;
        }

        return Scaffold(
          key: scaffoldKey,
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategorySuccess) {
                Navigator.of(context).pop();

                BlocProvider.of<BarGraphCubit>(context).getBarGraphData(
                  databaseService: widget.databaseService,
                  startDate: initialSelectedRange.startDate.toString(),
                  endDate: initialSelectedRange.endDate.toString(),
                );
              }

              if (state is CategoryError) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                ));
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: darkMode == true
                            ? [
                                kColorDarkModeBG,
                                kColorDarkModeBG,
                                kColorDarkModeBG
                              ]
                            : [kColorViolet1, kColorViolet1, kColorViolet2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BackButtonWidget(),
                            SizedBox(height: 20),
                            Text(
                              widget.isEdit ? 'Edit Category' : 'Add Category',
                              style: ktitleHeader,
                            ),
                            SizedBox(height: 20),
                            CustomInputField(
                              textController: categoryNameTextController,
                              hintText: 'Add a category',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Category name is required.';
                                } else if (value is String) {
                                  try {
                                    if (!regex.hasMatch(value)) {
                                      return 'Category name only accepts letters.';
                                    } else {
                                      double.parse(value);
                                      return 'Category name only accepts letters.';
                                    }
                                  } catch (err) {
                                    return null;
                                  }
                                }

                                return null;
                              },
                            ),
                            CustomInputField(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              textController: categoryLimitTextController,
                              keyboardType: TextInputType.number,
                              hintText: 'Add a limit',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Category limit is required.';
                                } else if (value is String) {
                                  try {
                                    double.parse(value);
                                    return null;
                                  } catch (err) {
                                    return 'Category limit only accepts number.';
                                  }
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomSubmitButton(
                              color: darkMode == true
                                  ? kColorTeal
                                  : kColorIndigo[400],
                              onPressed: state is! CategoryLoading
                                  ? () async => await submitOnPressed()
                                  : null,
                              child: state is CategoryLoading
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
      },
    );
  }
}
