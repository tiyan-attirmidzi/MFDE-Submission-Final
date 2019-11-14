class ModelMealDetail {

  String idMeal;
  String strMeal;
  String strCategory;
  String strInstructions;
  String strMealThumb;
  String strIngredient1;
  String strIngredient2;
  String strIngredient3;
  String strIngredient4;
  String strIngredient5;
  String strMeasure1;
  String strMeasure2;
  String strMeasure3;
  String strMeasure4;
  String strMeasure5;

  ModelMealDetail({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strInstructions,
    this.strMealThumb,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5
  });

  factory ModelMealDetail.fromJson(Map<String, dynamic> json) {
    return ModelMealDetail(
      idMeal                        : json['idMeal'] as String,
      strMeal                       : json['strMeal'] as String,
      strCategory                   : json['strCategory'] as String,
      strInstructions               : json['strInstructions'] as String,
      strMealThumb                  : json['strMealThumb'] as String,
      strIngredient1                : json['strIngredient1'] as String,
      strIngredient2                : json['strIngredient2'] as String,
      strIngredient3                : json['strIngredient3'] as String,
      strIngredient4                : json['strIngredient4'] as String,
      strIngredient5                : json['strIngredient5'] as String,
      strMeasure1                   : json['strMeasure1'] as String,
      strMeasure2                   : json['strMeasure2'] as String,
      strMeasure3                   : json['strMeasure3'] as String,
      strMeasure4                   : json['strMeasure4'] as String,
      strMeasure5                   : json['strMeasure5'] as String
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idMeal']                  = this.idMeal;
    data['strMeal']                 = this.strMeal;
    data['strCategory']             = this.strCategory;
    data['strInstructions']         = this.strInstructions;
    data['strMealThumb']            = this.strMealThumb;
    data['strIngredient1']          = this.strIngredient1;
    data['strIngredient2']          = this.strIngredient2;
    data['strIngredient3']          = this.strIngredient3;
    data['strIngredient4']          = this.strIngredient4;
    data['strIngredient5']          = this.strIngredient5;
    data['strMeasure1']             = this.strMeasure1;
    data['strMeasure2']             = this.strMeasure2;
    data['strMeasure3']             = this.strMeasure3;
    data['strMeasure4']             = this.strMeasure4;
    data['strMeasure5']             = this.strMeasure5;

    return data;
  }

  void setFavoriteId(String id) {
    this.idMeal = id;
  }
  
}