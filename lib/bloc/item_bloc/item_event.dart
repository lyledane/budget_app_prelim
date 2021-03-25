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

class AddItemEvent extends ItemEvent {
  final DatabaseService databaseService;
  final int categoryId;
  final String itemName;
  final double itemAmount;
  final String dateSpent;
  final String startDate;
  final String endDate;

  AddItemEvent({
    this.databaseService,
    this.categoryId,
    this.itemName,
    this.itemAmount,
    this.dateSpent,
    this.startDate,
    this.endDate,
  });
}

class UpdateItemEvent extends ItemEvent {
  final DatabaseService databaseService;
  final int itemId;
  final int categoryId;
  final String itemName;
  final double itemAmount;
  final String dateSpent;
  final String startDate;
  final String endDate;

  UpdateItemEvent({
    this.databaseService,
    this.itemId,
    this.categoryId,
    this.itemName,
    this.itemAmount,
    this.dateSpent,
    this.startDate,
    this.endDate,
  });
}

class DeleteItemEvent extends ItemEvent {
  final DatabaseService databaseService;
  final int itemId;
  final int categoryId;
  final String startDate;
  final String endDate;

  DeleteItemEvent({
    this.databaseService,
    this.itemId,
    this.categoryId,
    this.startDate,
    this.endDate,
  });
}
