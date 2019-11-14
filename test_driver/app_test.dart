import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Meals Catalogue App', () {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });


    String mealName               = "";
    final favNavBarDessert        = find.byValueKey("fav_dessert");
    final favNavBarSeafood        = find.byValueKey("fav_seafood");
    final bottomNavBarDessert     = find.byValueKey('option_dessert');
    final bottomNavBarSeafood     = find.byValueKey('option_seafood');
    final bottomNavBarFavorite    = find.byValueKey('option_favorite');
    final searchField             = find.byValueKey('search_field');
    final snackBar                = find.byValueKey("snackBar");
    final snackBarAction          = find.byValueKey("snack_bar_action");
    final snackBarText            = find.byValueKey("snack_bar_text");
    final itemMeal                = find.byValueKey("item_meal_52893_text");
    final itemMealDetail          = find.byValueKey("item_meal_detail");
    final processLoadMeal         = find.byValueKey("process_load_meal");
    final processLoadMealDetail   = find.byValueKey("process_load_meal_detail");
    final titleAppBarDetail       = find.byValueKey("title_appbar_detail");
    final titleAppBar             = find.byValueKey("title_appbar");

    final navButtonTabDessert = find.text('Dessert');
    final mealsNameOne = find.text("Apple & Blackberry Crumble");
    final mealsNameTwo = find.text("Apple Frangipan Tart");
    final navButtonTabFavorite = find.text('Favorite');
    final favoriteButton = find.byTooltip('Favorite');
    final tabFavoriteDessert = find.text('Dessert');

    test('Show Dessert nav button', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(navButtonTabDessert), "Dessert");
    });

    test('Show Meals : Apple & Blackberry Crumble', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Show Recipe', () async {
      // First, tap on the button
      await driver.tap(mealsNameOne);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Show Favorite button', () async {
      // First, tap on the button
      await driver.tap(favoriteButton);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Back to home', () async {
      // First, tap on the button
      await driver.tap(find.byTooltip('Back'));

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameTwo), "Apple Frangipan Tart");
    });

    test('Show Favorite nav button', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(navButtonTabFavorite), "Favorite");
    });

    test('Show Favorite', () async {
      // First, tap on the button
      await driver.tap(navButtonTabFavorite);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(tabFavoriteDessert), "Dessert");
    });

    // test("Open a meal detail", () async {
    //   await driver.waitForAbsent(processLoadMeal);
    //   mealName = await driver.getText(itemMeal);
    //   await driver.tap(itemMeal);
    //   await driver.waitForAbsent(itemMeal);
    //   await driver.waitForAbsent(snackBar);
    //   await driver.tap(snackBarText);
    //   expect(await driver.getText(titleAppBarDetail), "Meal Detail");
    //   expect(await driver.getText(itemMealDetail), mealName);
    // });

    // test("Open a meal detail", () async {
    //   await driver.tap(bottomNavBarSeafood);
    //   expect(await driver.getText(bottomNavBarSeafood), "Seafood");
    // });

    
    

  });
}