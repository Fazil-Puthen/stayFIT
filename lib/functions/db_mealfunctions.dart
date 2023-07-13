import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:async';

import '../models/foodmodel.dart';

ValueNotifier<List<FoodModel>> breakfastnotifier = ValueNotifier([]);
ValueNotifier<List<FoodModel>> lunchnotifier = ValueNotifier([]);
ValueNotifier<List<FoodModel>> dinnernotifier = ValueNotifier([]);

Future<void> addmealtime(FoodModel data, String selectedmeal) async {
  final mealDB1 = await Hive.openBox<FoodModel>('Breakfast');
  final mealDB2 = await Hive.openBox<FoodModel>('Lunch');
  final mealDB3 = await Hive.openBox<FoodModel>('Dinner');
  if (selectedmeal == 'Breakfast') {
    final id = await mealDB1.add(data);
    final value = mealDB1.get(id);
    mealDB1.put(
        id,
        FoodModel(
            name: value!.name,
            calorie: value.calorie,
            id: id,
            portion: value.portion));
    data.id = id;
    breakfastnotifier.value.add(data);
    breakfastnotifier.notifyListeners();
  } else if (selectedmeal == 'Lunch') {
    final id = await mealDB2.add(data);
    final value = mealDB2.get(id);
    mealDB2.put(
        id,
        FoodModel(
            name: value!.name,
            calorie: value.calorie,
            id: id,
            portion: value.portion));
    data.id = id;
    lunchnotifier.value.add(data);
    lunchnotifier.notifyListeners();
  } else {
    final id = await mealDB3.add(data);
    final value = mealDB3.get(id);
    mealDB3.put(
        id,
        FoodModel(
            name: value!.name,
            calorie: value.calorie,
            id: id,
            portion: value.portion));
    data.id = id;
    dinnernotifier.value.add(data);
    dinnernotifier.notifyListeners();
  }
}

Future<void> getmeallist() async {
  final mealDB1 = await Hive.openBox<FoodModel>('Breakfast');
  final mealDB2 = await Hive.openBox<FoodModel>('Lunch');
  final mealDB3 = await Hive.openBox<FoodModel>('Dinner');
  breakfastnotifier.value.clear();
  breakfastnotifier.value.addAll(mealDB1.values);
  breakfastnotifier.notifyListeners();
  lunchnotifier.value.clear();
  lunchnotifier.value.addAll(mealDB2.values);
  lunchnotifier.notifyListeners();
  dinnernotifier.value.clear();
  dinnernotifier.value.addAll(mealDB3.values);
  dinnernotifier.notifyListeners();
}

Future<void> deletemeal(int id, selectedmeal) async {
  final mealDB1 = await Hive.openBox<FoodModel>('Breakfast');
  final mealDB2 = await Hive.openBox<FoodModel>('Lunch');
  final mealDB3 = await Hive.openBox<FoodModel>('Dinner');
  if (selectedmeal == 'Breakfast') {
    await mealDB1.delete(id);
    getmeallist();
  } else if (selectedmeal == 'Lunch') {
    await mealDB2.delete(id);
    getmeallist();
  } else {
    await mealDB3.delete(id);
    getmeallist();
  }
}
