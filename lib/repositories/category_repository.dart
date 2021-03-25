import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  final Database dbInstance;
  final String categoryTable;

  CategoryRepository(this.dbInstance, this.categoryTable);
}
