part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class GetItemsEvent extends ItemEvent {
  final DatabaseService databaseService;
  final int categoryId;
  final String startDate;
  final String endDate;

  GetItemsEvent({
    this.databaseService,
    this.categoryId,
    this.startDate,
    this.endDate,
  });
}


