import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';

class MealsScreen extends StatelessWidget {
  final Category category;

  MealsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} Yemekleri'),
      ),
      body: FutureBuilder(
        // Kategorinin yemekleri getiren işlem başladığında bir yükleme ekranı gösterilir.
        future: Provider.of<MealProvider>(context, listen: false)
            .fetchMeals(category.name),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            // Veriler yüklenirken bekleyen bir yükleme animasyonu gösterilir.
            return Center(child: CircularProgressIndicator());
          } else if (dataSnapshot.error != null) {
            // Bir hata oluşursa, kullanıcıya hata mesajı gösterilir.
            return Center(child: Text('Bir hata oluştu!'));
          } else {
            // Veriler başarılı şekilde alındıysa, ListView ile yemek listesi gösterilir.
            return Consumer<MealProvider>(
              builder: (ctx, mealProvider, child) => ListView.builder(
                itemCount: mealProvider.meals.length,
                itemBuilder: (ctx, index) {
                  Meal meal = mealProvider.meals[index];
                  return GestureDetector(
                    onTap: () {
                      // Kullanıcı bir yemeğe tıkladığında, o yemeğin detayları gösterilir.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MealDetailScreen(meal: meal),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          meal.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(meal.name),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  MealDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: Center(
        // Yemek detayları ekranında Hero animasyonu ile yemeğin resmi büyütülerek gösterilir.
        child: Hero(
          tag: meal.id,
          child: Image.network(
            meal.imageUrl,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
