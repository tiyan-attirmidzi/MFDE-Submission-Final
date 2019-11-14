import 'package:meals_catalogue_final/models/model_meal_detail.dart';

class AdapterMealDetail {
  List<ModelMealDetail> modelMealDetail;

  AdapterMealDetail({this.modelMealDetail});

  AdapterMealDetail.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      modelMealDetail = List<ModelMealDetail>();
      json['meals'].forEach((v) {
        modelMealDetail.add(ModelMealDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.modelMealDetail != null) {
      data['recipe'] = this.modelMealDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
