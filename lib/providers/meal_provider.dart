// TODO Implement this library.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Meal> _meals = [];

  List<Category> get categories => _categories;
  List<Meal> get meals => _meals;

  Future<void> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      List<Category> loadedCategories = [];
      final extractedData =
          json.decode(response.body)['categories'] as List<dynamic>;
      for (var category in extractedData) {
        loadedCategories.add(Category.fromJson(category));
      }
      _categories = loadedCategories;
      notifyListeners();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchMeals(String category) async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));
    if (response.statusCode == 200) {
      List<Meal> loadedMeals = [];
      final extractedData =
          json.decode(response.body)['meals'] as List<dynamic>;
      for (var meal in extractedData) {
        loadedMeals.add(Meal.fromJson(meal));
      }
      _meals = loadedMeals;
      notifyListeners();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
