part of 'selected_range_cubit.dart';

@immutable
abstract class SelectedRangeState {}

class SelectedRangeInitial extends SelectedRangeState {}

class SelectedRangeSaved extends SelectedRangeState {
  final String startDate;
  final String endDate;

  SelectedRangeSaved({this.startDate, this.endDate});
}
