import 'package:intl/intl.dart';

class TextFormatter {
  final money = NumberFormat("#,##0.00", "en_PH");

/* Two decimal number without rounding */
  String parseAmount(double value) {
    String parsedAmount = '0.00';

    if (value != null) {
      parsedAmount = money.format(value);
    }

    return parsedAmount;
  }

  String parseDate({
    DateTime date,
    String dateFromDB,
    bool fromDatabase = false,
  }) {
    DateTime toBeFormattedDate;

    if (fromDatabase) {
      toBeFormattedDate = DateTime.parse(dateFromDB);
    } else {
      toBeFormattedDate = date;
    }

    return DateFormat('MMMM dd, yyyy').format(toBeFormattedDate);
  }

  String parseDateByDay(String value) => DateFormat('E').format(
        DateTime.parse(value),
      );

  double removeMoneyFormat(String value) =>
      double.parse(value.split('.00').first.replaceAll(',', ''));

  String removeMoneyFormatString(String value) =>
      value.split('.0').first.replaceAll(',', '');

  double buildPercent({double limit, double spent}) {
    double finalPercentage = 0;

    if (spent != 0) {
      double quo = spent / limit;

      if (quo == 1) {
        quo = 1;
      }
      finalPercentage = quo;
    }

    return finalPercentage;
  }
}
