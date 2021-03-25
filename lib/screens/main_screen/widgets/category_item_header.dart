import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/global_widgets/add_button.dart';
import 'package:budget_app_prelimm/global_widgets/back_button.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:flutter/material.dart';

class CategoryItemHeader extends StatelessWidget {
  final DatabaseService databaseService;
  final int categoryId;
  final double categoryLimit;

  const CategoryItemHeader({
    Key key,
    this.databaseService,
    this.categoryId,
    this.categoryLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButtonWidget(),
        AddButton(
          addOnPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.addEditItemScreen,
              arguments: {
                'databaseService': databaseService,
                'categoryId': categoryId,
                'categoryLimit': categoryLimit,
                'isEdit': false,
              },
            );
          },
        ),
      ],
    );
  }
}
