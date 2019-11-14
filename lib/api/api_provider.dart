import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:meals_catalogue_final/adapters/adapter_meal.dart';
import 'package:meals_catalogue_final/adapters/adapter_meal_detail.dart';
import 'package:meals_catalogue_final/database/DBhelper.dart';
import 'package:meals_catalogue_final/models/model_favorite.dart';
import 'package:meals_catalogue_final/models/model_meal_detail.dart';
import 'package:meals_catalogue_final/utils/util_helper.dart';

class ApiProvider {

  Client    client                = Client();
  int       currentBottomNav      = 0;
  int       currentFavoriteNav    = 0;
  bool      isSearching           = false;
  String    searchQuery           = "";

  Future<AdapterMeal> fetchData({int currentBottomNav = 0, int currentFavNav = 0, bool isSearching = false, String querySearch = ""}) async {

    AdapterMeal adapterMeal;
    String options;

    if (currentBottomNav < 2) {
      switch (currentBottomNav) {
        case 1:
          options = "filter.php?c=Seafood";
        break;
        default:
          options = "filter.php?c=Dessert";
        break;
      }
      if (isSearching && querySearch.isNotEmpty) {
        options = "search.php?s=$querySearch";
      }
      var res                   = await client.get(UtilHelper.baseURL + options);
      final resJSON             = jsonDecode(res.body);
      adapterMeal               = AdapterMeal.fromJson(resJSON);
    }
    else {
      var db                    = DBhelper();
      var categoryMeal          = "";
      if (currentFavNav == 0) {
        categoryMeal            = "Dessert";
      }
      else {
        categoryMeal            = "Seafood";
      }
      var data;
      if (isSearching && querySearch.isNotEmpty) {
        data = await db.searchMeals(querySearch);
      }
      else {
        data = await db.selectMealsByCategory(categoryMeal);
      }
      adapterMeal = AdapterMeal.fromDb(data);
    }
    return adapterMeal;
  } 

  Future<ModelFavorite> fetchDetail({String idMeal}) async {

    AdapterMealDetail adapterMealDetail;
    ModelMealDetail modelMealDetail;

    bool isFavorite               = false;
    var res                       = await client.get(UtilHelper.baseURL + "lookup.php?i=" + idMeal);
    final resJSON                 = jsonDecode(res.body);

    adapterMealDetail = AdapterMealDetail.fromJson(resJSON);
    if (adapterMealDetail != null && adapterMealDetail.modelMealDetail != null) {
      modelMealDetail = adapterMealDetail.modelMealDetail[0];
    }

    var db = DBhelper();
    if (modelMealDetail != null) {
      isFavorite = await db.isFavorite(modelMealDetail);
    }

    ModelFavorite data = ModelFavorite(modelMealDetail: modelMealDetail, isFavorite: isFavorite);
    return data;
  }

}
