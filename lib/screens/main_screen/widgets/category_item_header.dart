import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/global_widgets/add_button.dart';
import 'package:budget_app_prelimm/global_widgets/back_button.dart';
import 'package:flutter/material.dart';

class CategoryItemHeader extends StatelessWidget {
  final int categoryId;
  final double categoryLimit;

  const CategoryItemHeader({
    Key key,
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
            );
          },
        ),
      ],
    );
  }
}
