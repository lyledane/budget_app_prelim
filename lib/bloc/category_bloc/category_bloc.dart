import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:budget_app_prelimm/models/category.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:meta/meta.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategoriesEvent) {
      yield CategoryLoading();

      await Future.delayed(Duration(seconds: 1));
      List<Category> _categories = await event.databaseService.getCategories(
        startDate: event.startDate,
        endDate: event.endDate,
      );

      yield CategorySuccess(categories: _categories);
    } else if (event is AddCategoryEvent) {
      Category categoryInfo = Category(
        categoryName: event.categoryName,
        categoryLimit: event.limit,
      );

      int result = await event.databaseService.checkIfCategoryExists(
        categoryName: event.categoryName,
      );

      if (result == 0) {
        yield CategoryLoading();

        await Future.delayed(Duration(seconds: 1));
        await event.databaseService.insertCategory(categoryInfo);

        List<Category> _categories = await event.databaseService.getCategories(
          startDate: event.startDate,
          endDate: event.endDate,
        );

        yield CategorySuccess(categories: _categories);
      } else {
        yield CategoryError(errorMessage: 'Category already exists.');
      }
    } else if (event is UpdateCategoryEvent) {
      Category categoryInfo = Category(
        id: event.categoryId,
        categoryName: event.categoryName,
        categoryLimit: event.limit,
      );

      int result = await event.databaseService.checkIfCategoryExists(
        categoryName: event.categoryName,
        categoryId: event.categoryId,
        fromEdit: true,
      );

      if (result == 0) {
        yield CategoryLoading();

        await Future.delayed(Duration(seconds: 1));
        await event.databaseService.updateCategory(categoryInfo);
        List<Category> _categories = await event.databaseService.getCategories(
          startDate: event.startDate,
          endDate: event.endDate,
        );

        yield CategorySuccess(categories: _categories);
      } else {
        yield CategoryError(errorMessage: 'Category already exists.');
      }
    } else if (event is DeleteCategoryEvent) {
      await Future.delayed(Duration(seconds: 1));
      await event.databaseService.deleteCategory(event.categoryId);
      List<Category> _categories = await event.databaseService.getCategories(
        startDate: event.startDate,
        endDate: event.endDate,
      );

      yield CategorySuccess(categories: _categories);
    }
  }
}
