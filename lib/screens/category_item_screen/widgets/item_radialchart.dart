import 'package:budget_app_prelimm/bloc/cubit/current_amount_cubit/current_amount_cubit.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ItemRadialChart extends StatelessWidget {
  final String categoryAmountLimit;
  final Color color;

  const ItemRadialChart({
    Key key,
    this.categoryAmountLimit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextFormatter textFormatter = TextFormatter();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: kColorWhite.withOpacity(0.40),
        borderRadius: BorderRadius.circular(35),
      ),
      child: BlocBuilder<CurrentAmountCubit, CurrentAmountState>(
        builder: (context, state) {
          double percentage = 0;
          String currentAmount = '0.00';

          if (state is CurrentAmountSuccess) {
            currentAmount = state.currentAmount;

            percentage = textFormatter.buildPercent(
              limit: textFormatter.removeMoneyFormat(categoryAmountLimit),
              spent: textFormatter.removeMoneyFormat(currentAmount),
            );
          }

          if (state is CurrentAmountLoading) {
            currentAmount = '...';
          }

          return CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 15.0,
            animation: true,
            percent: percentage,
            center: Text(
              '₱ $currentAmount',
              style: kCategoryPriceText.copyWith(
                color: color,
                fontSize: 18,
              ),
            ),
            footer: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Current limit: ₱ $categoryAmountLimit',
                style: kCategoryPriceText.copyWith(
                  color: color,
                  fontSize: 18,
                ),
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: kColorBarLightBlue,
            backgroundColor: kColorWhite,
          );
        },
      ),
    );
  }
}
