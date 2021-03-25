import 'package:bloc/bloc.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meta/meta.dart';

part 'bar_graph_state.dart';

class BarGraphCubit extends Cubit<BarGraphState> {
  BarGraphCubit() : super(BarGraphInitial());

  Future<void> getBarGraphData({
    DatabaseService databaseService,
    String startDate,
    String endDate,
  }) async {
    emit(BarGraphLoading());

    List<BarChartGroupData> barChartGroupData =
        await databaseService.getBarGraphData(
      startDate: startDate,
      endDate: endDate,
    );

    emit(BarGraphSuccess(barChartData: barChartGroupData));
  }
}
