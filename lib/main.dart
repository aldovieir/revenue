import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'utilts/app_routes.dart';
import 'screens/meal_datail_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    this.settings = settings;
    setState(() {
      _availableMeal = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && meal.isLactoseFree;
        final filterVegan = settings.isVegan && meal.isVegan;
        final filterVegetarian = settings.isVegetarian && meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

bool _isFavorite(Meal meal){
  return _favoriteMeals.contains(meal);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORYS_MEALS: (ctx) => CategoryMealsScreen(_availableMeal),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDatailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettinsScreen(settings, _filterMeals),
      },
    );
  }
}
