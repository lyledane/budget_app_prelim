import 'package:budget_app_prelimm/global_widgets/custom_input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final bool isEdit;
  final Category category;

  const AddEditCategoryScreen({
    Key key,
    this.isEdit = false,
    this.category,
  }) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController categoryNameTextController;
  TextEditingController categoryLimitTextController;
  int categoryId;

  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;

  bool darkMode = false;

  Future<void> submitOnPressed() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
        );
      },
    );
  }

  @override
  void initState() {
    categoryNameTextController = TextEditingController();
    categoryLimitTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CustomInputField(
                    textController: categoryNameTextController,
                    hintText: 'Add a category',
                    validator: (value) {},
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
