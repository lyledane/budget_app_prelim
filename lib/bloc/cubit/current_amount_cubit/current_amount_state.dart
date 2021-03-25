part of 'current_amount_cubit.dart';

@immutable
abstract class CurrentAmountState {}

class CurrentAmountInitial extends CurrentAmountState {}

class CurrentAmountLoading extends CurrentAmountState {}

class CurrentAmountSuccess extends CurrentAmountState {
  final String currentAmount;
  CurrentAmountSuccess({this.currentAmount});
}
