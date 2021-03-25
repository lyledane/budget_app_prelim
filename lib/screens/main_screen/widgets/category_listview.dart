import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/custom_icon_slide_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryListView extends StatefulWidget {
  final List<Category> categories;
  final PickerDateRange initialSelectedRange;

  const CategoryListView({
    Key key,
    this.categories,
    this.initialSelectedRange,
  }) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
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
                          'Delete  [Sample]',
                          style: kCategoryItemTitle.copyWith(
                            color: kColorBlack,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete [CategorySample] from category list?',
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
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category Name',
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
                percent: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
