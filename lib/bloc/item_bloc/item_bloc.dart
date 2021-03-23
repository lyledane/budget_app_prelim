import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:budgets_app/models/item.dart';
import 'package:budgets_app/services/database_service.dart';
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
    }
  }
}
