import 'package:budget_app_prelimm/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateRangePickerController _controller;
  PickerDateRange initialSelectedRange;
  DateTime startDate;
  DateTime endDate;

  bool darkMode = false;

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate;
    DateTime date2 = ranges.endDate ?? ranges.startDate;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!isSameDate(dat1, ranges.startDate) ||
        !isSameDate(dat2, ranges.endDate)) {
      print('Start $dat1');
      print('end $dat2');

      _controller.selectedRange = PickerDateRange(dat1, dat2);
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  @override
  void initState() {
    _controller = DateRangePickerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            darkMode == true ? kColorDarkModeSurface : kColorViolet1,
        title: Text(
          'Select date',
          style: ktitleHeader.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SafeArea(
        child: SfDateRangePicker(
          backgroundColor: darkMode == true ? kColorDarkModeBG : kColorWhite,
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: kSubText.copyWith(
              color: darkMode == true ? kColorWhite : kColorBlack,
            ),
          ),
          rangeSelectionColor: darkMode == true ? kColorTeal[300] : null,
          selectionTextStyle: kSubText.copyWith(
            color: darkMode == true ? kColorWhite : kColorBlack,
          ),
          rangeTextStyle: kSubText.copyWith(
            color: darkMode == true ? kColorWhite : kColorBlack,
          ),
          yearCellStyle: DateRangePickerYearCellStyle(
            textStyle: kSubText.copyWith(
              color: darkMode == true ? kColorWhite : kColorBlack,
            ),
            todayTextStyle: kSubText.copyWith(
              color: darkMode == true ? kColorWhite : kColorBlack,
            ),
          ),
          initialSelectedRange: initialSelectedRange,
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor:
                darkMode == true ? kColorDarkModeBG : kColorViolet1,
            textStyle: ktitleHeader.copyWith(fontSize: 18),
          ),
          controller: _controller,
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: selectionChanged,
          monthViewSettings: DateRangePickerMonthViewSettings(
            enableSwipeSelection: false,
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: kSubText.copyWith(
                  color: darkMode == true ? kColorWhite : kColorBlack),
            ),
          ),
        ),
      ),
    );
  }
}
