import 'package:budget_app_prelimm/constants/style.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraphService {
  BarChartGroupData checkIfDateSpent({
    int key,
    String day,
    String referencedDay,
    double limit,
    double spent,
  }) {
    print(day == referencedDay);

    if (day == referencedDay) {
      return BarChartGroupData(
        x: key,
        barRods: [
          BarChartRodData(
            y: (spent / limit) * 100,
            width: 22,
            colors: [kColorBarLightBlue],
            backDrawRodData: BackgroundBarChartRodData(
              y: 100,
              show: true,
              colors: [kColorWhite],
            ),
          ),
        ],
      );
    } else {
      return BarChartGroupData(
        x: key,
        barRods: [
          BarChartRodData(
            y: 0,
            width: 22,
            colors: [kColorBarLightBlue],
            backDrawRodData: BackgroundBarChartRodData(
              y: 100,
              show: true,
              colors: [kColorWhite],
            ),
          ),
        ],
      );
    }
  }

  List<BarChartGroupData> barGraphPlaceHolder() {
    List<BarChartGroupData> data = [];

    for (int i = 0; i <= 6; i++) {
      data.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            y: 0,
            width: 22,
            colors: [kColorBarLightBlue],
            backDrawRodData: BackgroundBarChartRodData(
              y: 100,
              show: true,
              colors: [kColorWhite],
            ),
          ),
        ],
      ));
    }

    return data;
  }

  String getTitleText(double index) {
    switch (index.toInt()) {
      case 0:
        return 'Su';
        break;
      case 1:
        return 'Mo';
        break;
      case 2:
        return 'Tu';
        break;
      case 3:
        return 'We';
        break;
      case 4:
        return 'Th';
        break;
      case 5:
        return 'Fr';
        break;
      case 6:
        return 'Sa';
        break;
      default:
        return '';
        break;
    }
  }
}
