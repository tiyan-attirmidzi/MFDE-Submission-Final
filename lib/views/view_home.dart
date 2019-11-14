import 'package:flutter/material.dart';
import 'package:meals_catalogue_final/adapters/adapter_meal.dart';
import 'package:meals_catalogue_final/api/api_provider.dart';
import 'package:meals_catalogue_final/views/view_detail.dart';
import 'package:meals_catalogue_final/utils/util_fonts.dart';

class ViewHome extends StatefulWidget {

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {

  AdapterMeal adapterMeal;
  TextEditingController querySearch;

  bool _isSearching                           = false;
  int _currentIndexFavNav                     = 0;
  int _currentIndexBottomNav                  = 0;
  String _querySearch                         = "";

  @override
  void initState() {
    querySearch = TextEditingController();
    fetchData();
    super.initState();
  }

  void _startSearchAction() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearchingAction() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      querySearch.clear();
      _updateSearchQuery("");
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _querySearch = newQuery;
    });
    fetchData();
  }

  void onFavNavTapped(int index) {
    setState(() {
      _currentIndexFavNav = index;
    });
    fetchData();
  }

  void onBottomNavTapped(int index) {
    setState(() {
      _currentIndexBottomNav = index;
    });
    fetchData();
  }

  fetchData() async {
    ApiProvider apiProvider   = ApiProvider();
    adapterMeal               = await apiProvider.fetchData(
      currentBottomNav        : _currentIndexBottomNav,
      currentFavNav           : _currentIndexFavNav,
      isSearching             : _isSearching,
      querySearch             : _querySearch);
    setState(() {
      adapterMeal             = adapterMeal;
    });
  }

  widgetBody() => _currentIndexBottomNav < 2 ? widgetMeals() : TabBarView(
    children: [
      widgetMeals(),
      widgetMeals(),
    ],
  );

  widgetMeals() => adapterMeal != null && adapterMeal.meals != null ? Builder(
    builder: (context) => GridView.count(
      crossAxisCount: 2,
      children: mealsContent(context, adapterMeal),
    )
  ) : Container(
    child: Center(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(90.0),),
          CircularProgressIndicator(),
          Padding(padding: EdgeInsets.all(5.0),),
          Text("Please Wait...", key: Key("process_load_meal"),)
        ],
      ),
    ),
  );

  mealsContent(BuildContext context, AdapterMeal adapterMeal) => adapterMeal.meals.map((row) => Padding(
    padding: EdgeInsets.all(2.0),
    child: InkWell(
      onTap: () {
        final String strMeal = row.strMeal;
        final snackBar = SnackBar(
          key: Key("snack_bar"),
          content: Text(
            'Open $strMeal ?',
            key: Key("snack_bar_text"),
          ),
          action: SnackBarAction(
            key: Key("snack_bar_action"),
            label: 'OK',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealsDetail(idMeal: row.idMeal)
                ),
              );
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: mealsCard(row),
    ),
  )).toList();

  List<Widget> _buildActionSearch() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (querySearch == null || querySearch.text.isEmpty) {
              _stopSearchingAction();
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }
    return <Widget> [ 
      IconButton(
        key: Key("option_search"),
        icon: Icon(
          Icons.search
        ),
        onPressed: _startSearchAction,
      ),
    ];
  }

  Widget _widgetSearchField() {
    return TextField(
      key: Key("search_field"),
      controller: querySearch,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.white
        ),
      ),
      style: TextStyle(
        color: Colors.white, 
        fontSize: 16.0
      ),
      onChanged: _updateSearchQuery,
    );
  }

  Widget favNavBar() { 
    return TabBar(
      onTap: onFavNavTapped,
      tabs: [
        Tab(
          key: Key("fav_dessert"),
          icon: Icon(Icons.cake),
          text: "Dessert",
        ),
        Tab(
          key: Key("fav_seafood"),
          icon: Icon(Icons.restaurant_menu),
          text: "Seafood",
        )
      ],
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      onTap: onBottomNavTapped,
      currentIndex: _currentIndexBottomNav,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.cake),
          title: Text(
            'Dessert',
            key: Key("option_dessert"),
            style: TextStyle(color: Colors.grey,),
          ),
          activeIcon: Icon(
            Icons.cake, 
            color: Colors.blue
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          title: Text(
            'Seafood',
            key: Key("option_seafood"),
            style: TextStyle(color: Colors.grey,),
          ),
          activeIcon: Icon(
            Icons.restaurant_menu, 
            color: Colors.blue
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text(
            'Favorite',
            key: Key("option_favorite"),
            style: TextStyle(color: Colors.grey,),
          ),
          activeIcon: Icon(
            Icons.favorite, 
            color: Colors.blue
          ),
        ),
      ],
    );
  }

  Widget mealsCard(item) {
    final String id = item.idMeal; 
    return Card(
      child: Hero(
        tag: item.strMealThumb.toString(),
        child: Material(
          child: InkWell(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FadeInImage.assetNetwork(
                  image: item.strMealThumb,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/img-placeholder.png',
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: Text(
                        item.strMeal,
                        key: Key("item_meal_${id}_text"),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
    
  Widget controller(String title) { 
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: _isSearching ? _widgetSearchField() : Text(
            title,
            style: TextStyle(
              fontFamily: Fonts.aBasterRules,
              fontSize: 34.0
            ),
          ),
          centerTitle: true,
          actions: _buildActionSearch(),
          bottom: _currentIndexBottomNav > 1 ? favNavBar() : null,
        ),
        body: widgetBody(),
        bottomNavigationBar: bottomNavBar()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var config = "Meals Catalogue";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.toString(),
      home: controller(config.toString()),
    );
  }

}
