import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/empty_placeholder.dart';
import 'package:budget_app_prelimm/models/category.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/category_listview.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CategoryList extends StatefulWidget {
  final DatabaseService databaseService;

  const CategoryList({
    Key key,
    this.databaseService,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectedRangeCubit, SelectedRangeState>(
          listener: (context, srs) {
            if (srs is SelectedRangeSaved) {
              startDate = DateTime.parse(srs.startDate);
              endDate = DateTime.parse(srs.endDate);

              initialSelectedRange = PickerDateRange(startDate, endDate);
            }
          },
        ),
        BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategorySuccess) {
              if (initialSelectedRange != null) {
                BlocProvider.of<BarGraphCubit>(context).getBarGraphData(
                  databaseService: widget.databaseService,
                  startDate: initialSelectedRange.startDate.toString(),
                  endDate: initialSelectedRange.endDate.toString(),
                );
              }
            }
          },
        ),
        BlocListener<DarkModeCubit, DarkModeState>(
          listener: (context, state) {
            if (state is DarkModeSuccess) {
              darkMode = state.isDarkModeEnabled;
            }
          },
        ),
      ],
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
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
                  'Categories',
                  style: kCategoryTitle.copyWith(
                    color: darkMode == true ? kColorWhite : null,
                  ),
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                buildWhen: (previous, current) {
                  if (current is CategoryError) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  List<Category> _categories = [];

                  if (state is CategoryLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is CategorySuccess) {
                    _categories = state.categories;
                  }

                  return _categories.length != 0
                      ? CategoryListView(
                          categories: _categories,
                          databaseService: widget.databaseService,
                          initialSelectedRange: initialSelectedRange,
                        )
                      : BlocBuilder<SelectedRangeCubit, SelectedRangeState>(
                          builder: (context, state) {
                            Widget _widget = EmptyPlaceholder(
                              text: 'Add category',
                            );

                            if (state is SelectedRangeInitial) {
                              _widget = EmptyPlaceholder(
                                text: 'Please select date',
                              );
                            }

                            return _widget;
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
