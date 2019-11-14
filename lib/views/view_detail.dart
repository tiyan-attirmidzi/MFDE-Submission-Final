import 'package:flutter/material.dart';
import 'package:meals_catalogue_final/models/model_favorite.dart';
import 'package:meals_catalogue_final/models/model_meal_detail.dart';
import 'package:meals_catalogue_final/api/api_provider.dart';
import 'package:meals_catalogue_final/database/DBhelper.dart';

class MealsDetail extends StatefulWidget {

  final String idMeal;

  MealsDetail({
    this.idMeal
  });

  @override
  _MealsDetailState createState() => _MealsDetailState();
}

class _MealsDetailState extends State<MealsDetail> {

  var isFavorite = false;

  ModelMealDetail modelMealDetail;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    ApiProvider apiProvider     = ApiProvider();
    ModelFavorite favorite      = await apiProvider.fetchDetail(idMeal: widget.idMeal);
    setState(() {
      modelMealDetail           = favorite.modelMealDetail;
      isFavorite                = favorite.isFavorite;
    });
  }

  setFavorite() async {
    var db                      = DBhelper();
    ModelMealDetail favorite    = ModelMealDetail(
      idMeal                    : modelMealDetail.idMeal,
      strMeal                   : modelMealDetail.strMeal,
      strCategory               : modelMealDetail.strCategory,
      strInstructions           : modelMealDetail.strInstructions,
      strMealThumb              : modelMealDetail.strMealThumb
    );

    if (!isFavorite) {
      await db.insertMeals(favorite);
    } 
    else {
      await db.deleteMeals(favorite);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Widget _widgetImage(strMealThumb) {
    return AspectRatio(
      aspectRatio: 10.0 / 6.0,
      child: Hero(
        tag: strMealThumb.toString(),
        child: Image.network(
          strMealThumb,
          fit: BoxFit.fitWidth
        ),
      )
    );
  }

  Widget _widgetTextTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }

  Widget _widgetTextIngredient(String measure, String ingredient) {
    return Text(
      "- $measure $ingredient",
      style: TextStyle(height: 1.5),
    );
  }

  Widget _widgetContent(c) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          _widgetImage(modelMealDetail.strMealThumb),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Column(
              children: <Widget>[
                Text(
                  modelMealDetail.strMeal,
                  key: Key("item_meal_detail"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ),
          Divider(height: 18.0,color: Colors.grey,),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _widgetTextTitle('Ingredients'),
                  SizedBox(height: 8.0),
                  _widgetTextIngredient(
                    modelMealDetail.strMeasure1,
                    modelMealDetail.strIngredient1
                  ),
                  _widgetTextIngredient(
                    modelMealDetail.strMeasure2,
                    modelMealDetail.strIngredient2
                  ),
                  _widgetTextIngredient(
                    modelMealDetail.strMeasure3,
                    modelMealDetail.strIngredient3
                  ),
                  _widgetTextIngredient(
                    modelMealDetail.strMeasure4,
                    modelMealDetail.strIngredient4
                  ),
                  _widgetTextIngredient(
                    modelMealDetail.strMeasure5,
                    modelMealDetail.strIngredient5
                  ),
                ],
              ),
            )
          ),
          Divider(height: 18.0,color: Colors.grey,),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _widgetTextTitle('Instructions'),
                  SizedBox(height: 8.0),
                  Text(
                    modelMealDetail.strInstructions,
                    style: TextStyle(height: 1.3),
                  )
                ],
              ),
            )
          ),
          SizedBox(height: 16.0)
        ],
      ),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Detail", key: Key("title_appbar_detail"),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border),
            onPressed: () {
              setFavorite();
            },
            tooltip: "Favorite",
          ),
        ],
      ),
      body: modelMealDetail == null ? Center(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(90.0),),
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.all(5.0),),
                Text("Please Wait...", key: Key("process_load_meal_detail"),)
              ],
            ),
          ),
        )
      ) : _widgetContent(context)
    );
  }
  
}
