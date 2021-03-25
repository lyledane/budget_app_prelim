import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/services/bar_graph_service.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarGraphSection extends StatefulWidget {
  final DatabaseService databaseService;

  const BarGraphSection({
    Key key,
    this.databaseService,
  }) : super(key: key);

  @override
  _BarGraphSectionState createState() => _BarGraphSectionState();
}

class _BarGraphSectionState extends State<BarGraphSection> {
  final TextFormatter textFormatter = TextFormatter();
  final BarGraphService barGraphService = BarGraphService();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedRangeCubit, SelectedRangeState>(
      listener: (context, state) {
        if (state is SelectedRangeSaved) {
          Navigator.of(context).pop();

          BlocProvider.of<CategoryBloc>(context).add(
            GetCategoriesEvent(
              databaseService: widget.databaseService,
              startDate: state.startDate,
              endDate: state.endDate,
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: BlocBuilder<SelectedRangeCubit, SelectedRangeState>(
                builder: (context, state) {
                  String _text = 'Please select date';

                  if (state is SelectedRangeSaved) {
                    _text =
                        '${textFormatter.parseDate(dateFromDB: state.startDate, fromDatabase: true)} to ${textFormatter.parseDate(dateFromDB: state.endDate, fromDatabase: true)}';
                  }

                  return Text(
                    _text,
                    style: kSubText.copyWith(color: kColorWhite, fontSize: 17),
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: kColorWhite.withOpacity(0.40),
                borderRadius: BorderRadius.circular(35),
              ),
              child: BlocBuilder<BarGraphCubit, BarGraphState>(
                builder: (context, state) {
                  List<BarChartGroupData> data = [];

                  if (state is BarGraphSuccess) {
                    data = state.barChartData;
                  }

                  return state is BarGraphLoading
                      ? Center(child: CircularProgressIndicator())
                      : BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                margin: 16,
                                showTitles: true,
                                getTextStyles: (value) => kBarGraphTitle,
                                getTitles: (double index) =>
                                    barGraphService.getTitleText(index),
                              ),
                            ),
                            barGroups: state is BarGraphInitial
                                ? barGraphService.barGraphPlaceHolder()
                                : data,
                          ),
                        );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
