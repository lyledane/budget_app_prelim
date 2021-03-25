import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/current_amount_cubit/current_amount_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/bloc/item_bloc/item_bloc.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/empty_placeholder.dart';
import 'package:budget_app_prelimm/models/item.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/widgets/item_listview.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ItemList extends StatefulWidget {
  final DatabaseService databaseService;
  final double categoryLimit;

  const ItemList({
    Key key,
    this.databaseService,
    this.categoryLimit,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
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

    var dm = BlocProvider.of<DarkModeCubit>(context).state;
    if (dm is DarkModeSuccess) {
      darkMode = dm.isDarkModeEnabled;
    }
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
            BlocConsumer<ItemBloc, ItemState>(
              listener: (context, state) {
                double currentAmount = 0;

                if (state is ItemSuccess) {
                  state.items.forEach((element) {
                    currentAmount = currentAmount + element.itemAmount;
                  });

                  BlocProvider.of<CurrentAmountCubit>(context)
                      .storeCurrentAmount(currentAmount);

                  BlocProvider.of<CategoryBloc>(context).add(
                    GetCategoriesEvent(
                      databaseService: widget.databaseService,
                      startDate: initialSelectedRange.startDate.toString(),
                      endDate: initialSelectedRange.endDate.toString(),
                    ),
                  );

                  if (initialSelectedRange != null) {
                    BlocProvider.of<BarGraphCubit>(context).getBarGraphData(
                      databaseService: widget.databaseService,
                      startDate: initialSelectedRange.startDate.toString(),
                      endDate: initialSelectedRange.endDate.toString(),
                    );
                  }

                  print(currentAmount.toString());
                }
              },
              builder: (context, state) {
                List<Item> _items = [];

                if (state is ItemLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is ItemSuccess) {
                  _items = state.items;
                }

                return (_items.length != 0)
                    ? ItemListView(
                        items: _items,
                        databaseService: widget.databaseService,
                        categoryLimit: widget.categoryLimit,
                        initialSelectedRange: initialSelectedRange,
                      )
                    : EmptyPlaceholder(text: 'Add item');
              },
            )
          ],
        ),
      ),
    );
  }
}
