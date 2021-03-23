import 'package:intl/intl.dart';

class TextFormatter {
  final money = NumberFormat("#,##0.00", "en_PH");

  String parseAmount(double value) {
    String parsedAmount = '0.00';

    if (value != null) {
      parsedAmount = money.format(value);
    }

    return parsedAmount;
  }
}
