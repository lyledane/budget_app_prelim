import 'package:budget_app_prelimm/models/category.dart';
import 'package:budget_app_prelimm/models/item.dart';
import 'package:sqflite/sqflite.dart';

final String categoryTable = 'categories_tbl';
final String itemsTable = 'items_tbl';

class DatabaseService {
  static Database _database;
  static DatabaseService _databaseService;

  /* Used to creating single instance of this class */
  DatabaseService._();
  factory DatabaseService() {
    if (_databaseService == null) {
      _databaseService = DatabaseService._();
    }

    return _databaseService;
  }

  /* Getting of database */
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDB();
    }

    return _database;
  }

  /* Creation or intialization of database */
  Future<Database> initializeDB() async {
    String dir = await getDatabasesPath();
    String path = dir + "budgetDB.db";

    // await deleteDatabase(path);

    Database dbHandler = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $categoryTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              category_name TEXT NOT NULL,
              category_limit DOUBLE NOT NULL
            )
        ''');

        await db.execute('''
            CREATE TABLE $itemsTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              category_id INTEGER NOT NULL,
              item_name TEXT NOT NULL,
              item_amount DOUBLE NOT NULL,
              date_spent TEXT NOT NULL
            )
        ''');
      },
    );

    return dbHandler;
  }

  /* Get all categories */
  Future<List<Category>> getCategories({
    String startDate,
    String endDate,
  }) async {
    List<Category> _categories = [];

    var dbInstance = await this.database;

    var result = await dbInstance.rawQuery('''
      SELECT t1.*, COALESCE(SUM(t2.item_amount), 0.0) AS total
      FROM $categoryTable t1 
      LEFT OUTER JOIN $itemsTable t2 ON t1.id = t2.category_id
      AND date(t2.date_spent) BETWEEN '${startDate.split(' ')[0]}' AND '${endDate.split(' ')[0]}'
      GROUP BY t1.id 
      ORDER BY t1.id, total, t1.category_limit DESC
      ''');

    /* Loop all the records of the result */
    print('GET RESULT: $result');
    result.forEach((element) async {
      if (element == null) {
        return;
      }

      /* Parse to category model */
      /*No Code Yet */
    });

    return _categories;
  }

  /* Insert category */
  /*No Code yet */

  Future<int> checkIfCategoryExists({
    String categoryName,
    int categoryId,
    bool fromEdit = false,
  }) async {
    var dbInstance = await this.database;
    var result;

    if (fromEdit) {
      result = await dbInstance.rawQuery('''
      SELECT * FROM $categoryTable 
      WHERE category_name = '$categoryName' AND id != $categoryId
    ''');
    } else {
      result = await dbInstance.rawQuery('''
      SELECT * FROM $categoryTable 
      WHERE category_name = '$categoryName'
      ''');
    }

    return result.length;
  }

  Future<void> updateCategory(Category category) async {
    // var dbInstance = await this.database;
  }

  /* Insert category */
  Future<void> deleteCategory(int categoryId) async {
    var dbInstance = await this.database;
    var result = await dbInstance.delete(
      categoryTable,
      where: 'id = ?',
      whereArgs: [categoryId],
    );

    print('Delete category result: $result');
  }

  ///////////////////////////// ITEMS FUNCTION ///////////////////////////
  /* Get all items */
  Future<List<Item>> getItems({
    int categoryId,
    String startDate,
    String endDate,
  }) async {
    List<Item> _items = [];

    var dbInstance = await this.database;
    var result = await dbInstance.rawQuery('''
      SELECT * FROM $itemsTable WHERE date(date_spent) 
      BETWEEN '${startDate.split(' ')[0]}' AND '${endDate.split(' ')[0]}' 
      AND category_id = $categoryId
      ORDER BY id DESC
      ''');

    print('JHAJSJASJJAJSA: $result');

    /* Loop all the records of the result */
    result.forEach((element) {
      if (element == null) {
        return;
      }

      /* Parse to category model */
      /* No Code yet */
    });

    return _items;
  }

  /* Insert category */
  Future<void> insertItem(Item item) async {
    // var dbInstance = await this.database;
  }

  Future<void> updateItem(Item item) async {
    // var dbInstance = await this.database;
    // var result = await dbInstance.update(
    //   itemsTable,
    //   item.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [item.id],
    // );
  }

  Future<void> deleteItem(int itemId) async {
    var dbInstance = await this.database;
    var result = await dbInstance.delete(
      itemsTable,
      where: 'id = ?',
      whereArgs: [itemId],
    );
    print('Delete item result: $result');
  }
}
