part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final DatabaseService databaseService;
  final String categoryName;
  final double limit;
  final String startDate;
  final String endDate;

  AddCategoryEvent({
    this.databaseService,
    this.categoryName,
    this.limit,
    this.startDate,
    this.endDate,
  });
}

class UpdateCategoryEvent extends CategoryEvent {
  final DatabaseService databaseService;
  final int categoryId;
  final String categoryName;
  final double limit;
  final String startDate;
  final String endDate;

  UpdateCategoryEvent({
    this.databaseService,
    this.categoryId,
    this.categoryName,
    this.limit,
    this.startDate,
    this.endDate,
  });
}

class DeleteCategoryEvent extends CategoryEvent {
  final DatabaseService databaseService;
  final int categoryId;
  final String startDate;
  final String endDate;

  DeleteCategoryEvent({
    this.databaseService,
    this.categoryId,
    this.startDate,
    this.endDate,
  });
}

class GetCategoriesEvent extends CategoryEvent {
  final DatabaseService databaseService;
  final String startDate;
  final String endDate;

  GetCategoriesEvent({
    this.databaseService,
    this.startDate,
    this.endDate,
  });
}
