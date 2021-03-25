import 'package:budget_app_prelimm/screens/add_edit_category_screen/add_edit_category_screen.dart';
import 'package:budget_app_prelimm/screens/add_edit_item_screen/add_edit_item_screen.dart';
import 'package:budget_app_prelimm/screens/calendar_screen/calendar_screen.dart';
import 'package:budget_app_prelimm/screens/category_item_screen/category_item_screen.dart';
import 'package:budget_app_prelimm/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String mainScreen = '/mainScreen';
  static const String categoryItemScreen = '/categoryItemScreen';
  static const String addEditCategorySCreen = '/addEditCategorySCreen';
  static const String addEditItemScreen = '/addEditItemScreen';
  static const String calendarScreen = '/calendarScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map args = settings.arguments;

    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case categoryItemScreen:
        return MaterialPageRoute(
          builder: (_) => CategoryItemScreen(
            databaseService: args['databaseService'],
            categoryId: args['categoryId'],
            categoryName: args['categoryName'],
            categoryLimit: args['categoryLimit'],
          ),
        );
      case addEditCategorySCreen:
        return MaterialPageRoute(
          builder: (_) => AddEditCategoryScreen(
            databaseService: args['databaseService'],
            isEdit: args['isEdit'],
            category: args['category'],
          ),
        );
      case addEditItemScreen:
        return MaterialPageRoute(
          builder: (_) => AddEditItemScreen(
            databaseService: args['databaseService'],
            categoryId: args['categoryId'],
            categoryLimit: args['categoryLimit'],
            isEdit: args['isEdit'],
            item: args['item'],
          ),
        );
      case calendarScreen:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
