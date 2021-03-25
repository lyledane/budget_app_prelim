import 'package:budget_app_prelimm/bloc/item_bloc/item_bloc.dart';
import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/global_widgets/custom_icon_slide_action.dart';
import 'package:budget_app_prelimm/models/item.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ItemListView extends StatefulWidget {
  final List<Item> items;
  final double categoryLimit;
  final DatabaseService databaseService;
  final PickerDateRange initialSelectedRange;

  const ItemListView({
    Key key,
    this.items,
    this.categoryLimit,
    this.databaseService,
    this.initialSelectedRange,
  }) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final TextFormatter textFormatter = TextFormatter();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(7),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Slidable(
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
                  AppRouter.addEditItemScreen,
                  arguments: {
                    'databaseService': widget.databaseService,
                    'categoryId': widget.items[index].categoryId,
                    'categoryLimit': widget.categoryLimit,
                    'isEdit': true,
                    'item': widget.items[index]
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
                          'Delete ${widget.items[index].itemName}',
                          style: kCategoryItemTitle.copyWith(
                            color: kColorBlack,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete ${widget.items[index].itemName} from item list?',
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

                              BlocProvider.of<ItemBloc>(context).add(
                                DeleteItemEvent(
                                  databaseService: widget.databaseService,
                                  categoryId: widget.items[index].categoryId,
                                  itemId: widget.items[index].id,
                                  startDate: widget
                                      .initialSelectedRange.startDate
                                      .toString(),
                                  endDate: widget.initialSelectedRange.endDate
                                      .toString(),
                                ),
                              );

                              setState(() {
                                widget.items.removeAt(index);
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
              title: Text(
                widget.items[index].itemName,
                style: kCategoryItemTitle,
              ),
              subtitle: Text(
                textFormatter.parseDate(
                  dateFromDB: widget.items[index].dateSpent,
                  fromDatabase: true,
                ),
                style: kSubText,
              ),
              trailing: Text(
                '- ₱ ${textFormatter.parseAmount(widget.items[index].itemAmount)}',
                style: kCategoryPriceText.copyWith(
                  color: kColorRed,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
