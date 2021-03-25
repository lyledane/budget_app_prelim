import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_range_state.dart';

class SelectedRangeCubit extends Cubit<SelectedRangeState> {
  SelectedRangeCubit() : super(SelectedRangeInitial());

  void saveSelectedRange({String startDate, String endDate}) {
    emit(SelectedRangeSaved(startDate: startDate, endDate: endDate));
  }
}
