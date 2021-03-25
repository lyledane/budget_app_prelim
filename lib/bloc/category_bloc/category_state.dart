part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categories;
  CategorySuccess({this.categories});
}

class CategoryError extends CategoryState {
  final String errorMessage;
  CategoryError({this.errorMessage});
}
