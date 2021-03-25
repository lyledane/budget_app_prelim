part of 'dark_mode_cubit.dart';

@immutable
abstract class DarkModeState {}

class DarkModeInitial extends DarkModeState {}

class DarkModeSuccess extends DarkModeState {
  final bool isDarkModeEnabled;
  DarkModeSuccess({this.isDarkModeEnabled});
}
