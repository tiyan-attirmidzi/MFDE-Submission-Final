import 'dart:io' as io;
import 'dart:async';
import 'package:meals_catalogue_final/models/model_meal_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBhelper {

  static final DBhelper _instance  = DBhelper.internal();
  DBhelper.internal();
  factory DBhelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory          = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mealsDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE favorite(
        id INTEGER PRIMARY KEY, 
        idMeal TEXT, 
        strMeal TEXT, 
        strCategory TEXT,
        strInstructions TEXT, 
        strMealThumb TEXT, 
        strIngredient1 TEXT, 
        strIngredient2 TEXT, 
        strIngredient3 TEXT, 
        strIngredient4 TEXT, 
        strIngredient5 TEXT, 
        strMeasure1 TEXT, 
        strMeasure2 TEXT, 
        strMeasure3 TEXT, 
        strMeasure4 TEXT, 
        strMeasure5 TEXT
      )
    """);
    print("DB Created");
  }

  Future<int> insertMeals(ModelMealDetail modelMealDetail) async {
    var dbClient                    = await db;
    int res                         = await dbClient.insert("favorite", modelMealDetail.toJson());
    print("Data Inserted");

    return res;
  }

  Future<ModelMealDetail> selectMeals(String idMeal) async {
    var dbClient                    = await db;
    List<Map> list                  = await dbClient.rawQuery(
      """
        SELECT *
        FROM favorite
        WHERE idMeal = ?
        ORDER BY idMeal DESC
      """,
      [idMeal]
    );
    ModelMealDetail modelMealDetail;
    if (list.length > 0) {
      modelMealDetail = ModelMealDetail(
        idMeal                      : list[0]["idMeal"],
        strMeal                     : list[0]["strMeal"],
        strCategory                 : list[0]["strCategory"],
        strInstructions             : list[0]["strInstructions"],
        strMealThumb                : list[0]["strMealThumb"],
        strIngredient1              : list[0]["strIngredient1"],
        strIngredient2              : list[0]["strIngredient2"],
        strIngredient3              : list[0]["strIngredient3"],
        strIngredient4              : list[0]["strIngredient4"],
        strIngredient5              : list[0]["strIngredient5"],
        strMeasure1                 : list[0]["strMeasure1"],
        strMeasure2                 : list[0]["strMeasure2"],
        strMeasure3                 : list[0]["strMeasure3"],
        strMeasure4                 : list[0]["strMeasure4"],
        strMeasure5                 : list[0]["strMeasure5"],
      );
    }
    return modelMealDetail;
  }

  Future<List<ModelMealDetail>> selectMealsByCategory(String category) async {
    var dbClient                    = await db;
    List<Map> list                  = await dbClient.rawQuery(
      """
        SELECT * 
        FROM favorite 
        WHERE strCategory = ? 
        ORDER BY idMeal DESC
      """,
      [category]
    );
    List<ModelMealDetail> favorites = List();
    for (int i = 0; i < list.length; i++) {
      ModelMealDetail favorite = ModelMealDetail(
        idMeal                      : list[i]["idMeal"],
        strMeal                     : list[i]["strMeal"],
        strCategory                 : list[i]["strCategory"],
        strInstructions             : list[i]["strInstructions"],
        strMealThumb                : list[i]["strMealThumb"],
        strIngredient1              : list[i]["strIngredient1"],
        strIngredient2              : list[i]["strIngredient2"],
        strIngredient3              : list[i]["strIngredient3"],
        strIngredient4              : list[i]["strIngredient4"],
        strIngredient5              : list[i]["strIngredient5"],
        strMeasure1                 : list[i]["strMeasure1"],
        strMeasure2                 : list[i]["strMeasure2"],
        strMeasure3                 : list[i]["strMeasure3"],
        strMeasure4                 : list[i]["strMeasure4"],
        strMeasure5                 : list[i]["strMeasure5"],
      );
      favorite.setFavoriteId(list[i]['idMeal']);
      favorites.add(favorite);
    }
    return favorites;
  }

  Future<List<ModelMealDetail>> searchMeals(String query) async {
    var dbClient                    = await db;
    List<Map> list                  = await dbClient.rawQuery(
      """
        SELECT *
        FROM favorite
        WHERE strMeal LIKE ? 
        ORDER BY idMeal DESC
      """,
      ["%$query%"]
    );
    List<ModelMealDetail> favorites = List();
    for (var i = 0; i < list.length; i++) {
      ModelMealDetail favorite = ModelMealDetail(
        idMeal                      : list[i]["idMeal"],
        strMeal                     : list[i]["strMeal"],
        strCategory                 : list[i]["strCategory"],
        strInstructions             : list[i]["strInstructions"],
        strMealThumb                : list[i]["strMealThumb"],
        strIngredient1              : list[i]["strIngredient1"],
        strIngredient2              : list[i]["strIngredient2"],
        strIngredient3              : list[i]["strIngredient3"],
        strIngredient4              : list[i]["strIngredient4"],
        strIngredient5              : list[i]["strIngredient5"],
        strMeasure1                 : list[i]["strMeasure1"],
        strMeasure2                 : list[i]["strMeasure2"],
        strMeasure3                 : list[i]["strMeasure3"],
        strMeasure4                 : list[i]["strMeasure4"],
        strMeasure5                 : list[i]["strMeasure5"],
      );
      favorite.setFavoriteId(list[i]['idMeal']);
      favorites.add(favorite);
    }
    return favorites;
  }

  Future<bool> isFavorite(ModelMealDetail modelMealDetail) async {
    var dbClient                      = await db;
    var res                           = await dbClient.rawQuery(
      """
        SELECT *
        FROM favorite
        WHERE idMeal = ?
      """,
      [modelMealDetail.idMeal]
    );
    return res.isNotEmpty;
  }

  Future<int> deleteMeals(ModelMealDetail modelMealDetail) async {
    var dbClient                       = await db;
    var res                            = dbClient.rawDelete(
      """
        DELETE
        FROM favorite
        WHERE idMeal = ?
      """,
      [modelMealDetail.idMeal]
    );
    print("Data Deleted");
    return res;
  }

}