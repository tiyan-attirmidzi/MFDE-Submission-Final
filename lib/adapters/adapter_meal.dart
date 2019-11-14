import 'package:meals_catalogue_final/models/model_meal.dart';
import 'package:meals_catalogue_final/models/model_meal_detail.dart';

class AdapterMeal {
  List<ModelMeal> meals;

  AdapterMeal({this.meals});

  AdapterMeal.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = List<ModelMeal>();
      json['meals'].forEach((v) {
        meals.add(ModelMeal.fromJson(v));
      });
    }
  }

  AdapterMeal.fromDb(List<ModelMealDetail> data) {
    if (data != null) {
      meals = List<ModelMeal>();
      data.forEach((favorite) {
        ModelMeal dataMeals = ModelMeal(
            idMeal: favorite.idMeal,
            strMeal: favorite.strMeal,
            strMealThumb: favorite.strMealThumb);
        meals.add(dataMeals);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.meals != null) {
      data['recipe'] = this.meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
