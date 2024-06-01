import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/meal_provider.dart'; // MealProvider'ı içe aktarır
import 'screens/category_screen.dart'; // CategoryScreen'ı içe aktarır

void main() {
  runApp(MyApp()); // Uygulamayı başlatır
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // MyApp sınıfını oluşturur

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                MealProvider()), // MealProvider'ı sağlayan ChangeNotifierProvider'ı oluşturur
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hata ayıklama bandını kaldırır
        title: 'Yemek Uygulaması', // Uygulamanın başlığını ayarlar
        theme: ThemeData(
          // Tema ayarlarını tanımlar
          primaryColor:
              Colors.green[400], // Ana tema rengini yeşil olarak belirler
          appBarTheme: AppBarTheme(
            color: Colors
                .green[400], // AppBar'ın arka plan rengini yeşil olarak ayarlar
          ),
          fontFamily: 'Montserrat', // Metin fontunu Montserrat olarak belirler
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors
                  .green), // Renk şemasını günceller, vurgu rengini yeşil olarak belirler
        ),
        home: CategoryScreen(), // Ana ekranı CategoryScreen olarak belirler
      ),
    );
  }
}
