class ModelMeal {

  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  ModelMeal({
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
  });

  factory ModelMeal.fromJson(Map<String, dynamic> json) {
    return ModelMeal(
      idMeal              : json['idMeal'] as String,
      strMealThumb        : json['strMealThumb'] as String,
      strMeal             : json['strMeal'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['strMeal']       = this.strMeal;
    data['strMealThumb']  = this.strMealThumb;
    data['idMeal']        = this.idMeal;
    return data;
  }

}