part of 'bar_graph_cubit.dart';

@immutable
abstract class BarGraphState {}

class BarGraphInitial extends BarGraphState {}

class BarGraphLoading extends BarGraphState {}

class BarGraphSuccess extends BarGraphState {
  final List<BarChartGroupData> barChartData;
  BarGraphSuccess({this.barChartData});
}
