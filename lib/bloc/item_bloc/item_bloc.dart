import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:budget_app_prelimm/models/item.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:meta/meta.dart';
part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is GetItemsEvent) {
      yield ItemLoading();

      await Future.delayed(Duration(seconds: 1));
      List<Item> _items = await event.databaseService.getItems(
        categoryId: event.categoryId,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      yield ItemSuccess(items: _items);
    } else if (event is AddItemEvent) {
      yield ItemLoading();

      Item item = Item(
        categoryId: event.categoryId,
        itemName: event.itemName,
        itemAmount: event.itemAmount,
        dateSpent: event.dateSpent,
      );

      await Future.delayed(Duration(seconds: 1));
      await event.databaseService.insertItem(item);

      List<Item> _items = await event.databaseService.getItems(
        categoryId: event.categoryId,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      yield ItemSuccess(items: _items);
    } else if (event is UpdateItemEvent) {
      yield ItemLoading();

      Item item = Item(
        id: event.itemId,
        categoryId: event.categoryId,
        itemName: event.itemName,
        itemAmount: event.itemAmount,
        dateSpent: event.dateSpent,
      );

      await Future.delayed(Duration(seconds: 1));
      await event.databaseService.updateItem(item);

      List<Item> _items = await event.databaseService.getItems(
        categoryId: event.categoryId,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      yield ItemSuccess(items: _items);
    } else if (event is DeleteItemEvent) {
      await Future.delayed(Duration(seconds: 1));
      await event.databaseService.deleteItem(event.itemId);
      List<Item> _items = await event.databaseService.getItems(
        categoryId: event.categoryId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      yield ItemSuccess(items: _items);
    }
  }
}
