import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/custom_icon_slide_action.dart';
import 'package:budget_app_prelimm/models/category.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CategoryListView extends StatefulWidget {
  final List<Category> categories;
  final DatabaseService databaseService;
  final PickerDateRange initialSelectedRange;

  const CategoryListView({
    Key key,
    this.categories,
    this.databaseService,
    this.initialSelectedRange,
  }) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  final TextFormatter textFormatter = TextFormatter();

  bool darkMode = false;

  @override
  void initState() {
    var dm = BlocProvider.of<DarkModeCubit>(context).state;
    if (dm is DarkModeSuccess) {
      darkMode = dm.isDarkModeEnabled;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(7),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return Slidable(
            closeOnScroll: true,
            key: Key('$index'),
            actionPane: SlidableDrawerActionPane(
              key: Key('$index'),
            ),
            actionExtentRatio: 0.25,
            secondaryActions: [
              CustomIconSlideAction(
                color: kColorIndigo,
                buttonText: 'Edit',
                icon: Icons.edit,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRouter.addEditCategorySCreen,
                  arguments: {
                    'databaseService': widget.databaseService,
                    'isEdit': true,
                    'category': widget.categories[index]
                  },
                ),
              ),
              CustomIconSlideAction(
                color: kColorRed,
                buttonText: 'Delete',
                icon: Icons.delete,
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Delete ${widget.categories[index].categoryName}',
                          style: kCategoryItemTitle.copyWith(
                            color: kColorBlack,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete ${widget.categories[index].categoryName} from category list?',
                          style: kCategoryItemTitle.copyWith(
                            color: kColorBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'Delete',
                              style: kSubText.copyWith(color: kColorRed),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();

                              BlocProvider.of<CategoryBloc>(context).add(
                                DeleteCategoryEvent(
                                  databaseService: widget.databaseService,
                                  categoryId: widget.categories[index].id,
                                  startDate: widget
                                      .initialSelectedRange.startDate
                                      .toString(),
                                  endDate: widget.initialSelectedRange.endDate
                                      .toString(),
                                ),
                              );

                              setState(() {
                                widget.categories.removeAt(index);
                              });
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
                },
              ),
            ],
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.categoryItemScreen,
                  arguments: {
                    'databaseService': widget.databaseService,
                    'categoryId': widget.categories[index].id,
                    'categoryName': widget.categories[index].categoryName,
                    'categoryLimit': textFormatter.parseAmount(
                      widget.categories[index].categoryLimit,
                    ),
                  },
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.categories[index].categoryName,
                    style: kCategoryItemTitle.copyWith(
                      color: darkMode == true ? kColorWhite : null,
                    ),
                  ),
                  Text(
                    '₱ ${textFormatter.parseAmount(widget.categories[index].totalSpent)} / ₱ ${textFormatter.parseAmount(widget.categories[index].categoryLimit)}',
                    style: kCategoryPriceText.copyWith(
                      color: darkMode == true ? kColorWhite : null,
                    ),
                  ),
                ],
              ),
              subtitle: LinearPercentIndicator(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                progressColor: kColorIndigo,
                backgroundColor: kColorGrey.withOpacity(0.50),
                lineHeight: 18,
                animation: true,
                animationDuration: 300,
                percent: textFormatter.buildPercent(
                  limit: widget.categories[index].categoryLimit,
                  spent: widget.categories[index].totalSpent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
