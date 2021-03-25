import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());

  void toggleDarkMode(bool isDarkModeEnabled) {
    isDarkModeEnabled = !isDarkModeEnabled;
    emit(DarkModeSuccess(isDarkModeEnabled: isDarkModeEnabled));
  }
}
