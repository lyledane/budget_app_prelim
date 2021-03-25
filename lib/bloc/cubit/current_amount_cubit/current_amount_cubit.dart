import 'package:bloc/bloc.dart';
import 'package:budget_app_prelimm/services/text_formatter.dart';
import 'package:meta/meta.dart';
part 'current_amount_state.dart';

class CurrentAmountCubit extends Cubit<CurrentAmountState> {
  CurrentAmountCubit() : super(CurrentAmountInitial());

  void storeCurrentAmount(double currentAmount) {
    TextFormatter textFormatter = TextFormatter();

    emit(CurrentAmountLoading());

    String parsedAmount = textFormatter.parseAmount(currentAmount);

    emit(CurrentAmountSuccess(currentAmount: parsedAmount));
  }
}
