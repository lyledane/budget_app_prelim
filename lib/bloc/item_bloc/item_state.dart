part of 'item_bloc.dart';

@immutable
abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemSuccess extends ItemState {
  final List<Item> items;
  ItemSuccess({this.items});
  

  
}
