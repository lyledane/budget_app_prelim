import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/bloc/item_bloc/item_bloc.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/widgets/item_list.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/widgets/item_radialchart.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/category_item_header.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CategoryItemScreen extends StatefulWidget {
  final DatabaseService databaseService;
  final String categoryName;
  final int categoryId;
  final String categoryLimit;

  const CategoryItemScreen({
    Key key,
    this.databaseService,
    this.categoryName,
    this.categoryId,
    this.categoryLimit,
  }) : super(key: key);

  @override
  _CategoryItemScreenState createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  final TextFormatter textFormatter = TextFormatter();

  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;

  bool darkMode = false;

  @override
  void initState() {
    var srs = BlocProvider.of<SelectedRangeCubit>(context).state;

    if (srs is SelectedRangeSaved) {
      startDate = DateTime.parse(srs.startDate);
      endDate = DateTime.parse(srs.endDate);

      initialSelectedRange = PickerDateRange(startDate, endDate);
    }

    BlocProvider.of<ItemBloc>(context).add(GetItemsEvent(
      databaseService: widget.databaseService,
      categoryId: widget.categoryId,
      startDate: initialSelectedRange.startDate.toString(),
      endDate: initialSelectedRange.endDate.toString(),
    ));

    var dm = BlocProvider.of<DarkModeCubit>(context).state;
    if (dm is DarkModeSuccess) {
      darkMode = dm.isDarkModeEnabled;
    }

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
                    CategoryItemHeader(
                      databaseService: widget.databaseService,
                      categoryId: widget.categoryId,
                      categoryLimit: textFormatter.removeMoneyFormat(
                        widget.categoryLimit,
                      ),
                    ),
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
              ItemList(
                databaseService: widget.databaseService,
                categoryLimit: textFormatter.removeMoneyFormat(
                  widget.categoryLimit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
