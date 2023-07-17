import 'package:flutter/material.dart';
import 'package:health_app/functions/db_dailystatusfunction.dart';
import 'package:health_app/models/dailymodel.dart';
import 'package:hive/hive.dart';

import '../models/foodmodel.dart';
import 'db_mealfunctions.dart';

ValueNotifier total = ValueNotifier(0);

Future<void> timeclear() async {
  final box = await Hive.openBox<FoodModel>('Breakfast');
  final box1 = await Hive.openBox<FoodModel>('Lunch');
  final box2 = await Hive.openBox<FoodModel>('Dinner');
  breakfastnotifier.value.clear();
  lunchnotifier.value.clear();
  dinnernotifier.value.clear();
  await box.clear();
  await box.close();
  await box1.clear();
  await box1.close();
  await box2.clear();
  await box2.close();
}

//Add the total calorie of a day
Future<void> sumcalorie(int day) async {
  final data = breakfastnotifier.value;
  final data2 = lunchnotifier.value;
  final data3 = dinnernotifier.value;

  double breakfasttotal = addtotalcalorie(data);
  double lunchtotal = addtotalcalorie(data2);
  double dinnertotal = addtotalcalorie(data3);

  double daycalorie = breakfasttotal + lunchtotal + dinnertotal;


  final value = DailyModel(
      day: day,
      breakfast: breakfasttotal,
      lunch: lunchtotal,
      dinner: dinnertotal,
      dailytotal: daycalorie);
  addtodailylist(value);
}

double addtotalcalorie(List<FoodModel> list) {
  double total = 0;
  for (var num in list) {
    total += num.calorie;
  }
  return total;
}
