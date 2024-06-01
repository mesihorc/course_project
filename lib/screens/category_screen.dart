import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/meal_provider.dart';
import './meals_screen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategoriler'),
      ),
      body: FutureBuilder(
        // Kategorileri getiren işlem başladığında bir yükleme ekranı gösterilir.
        future:
            Provider.of<MealProvider>(context, listen: false).fetchCategories(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            // Veriler yüklenirken bekleyen bir yükleme animasyonu gösterilir.
            return Center(child: CircularProgressIndicator());
          } else if (dataSnapshot.error != null) {
            // Bir hata oluşursa, kullanıcıya hata mesajı gösterilir.
            return Center(child: Text('Bir hata oluştu!'));
          } else {
            // Veriler başarılı şekilde alındıysa, ListView ile kategori listesi gösterilir.
            return Consumer<MealProvider>(
              builder: (ctx, mealProvider, child) => ListView.builder(
                itemCount: mealProvider.categories.length,
                itemBuilder: (ctx, index) {
                  Category category = mealProvider.categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Kullanıcı bir kategoriye tıkladığında, o kategoriye ait yemek listesi gösterilir.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MealsScreen(category: category),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Hero(
                          tag: category.id,
                          child: Image.network(
                            category.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(category.name),
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
