import 'package:health_app/functions/db_mealfunctions.dart';

import '../models/foodmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<FoodModel>> gainfoodNotifier = ValueNotifier([]);
ValueNotifier<List<FoodModel>> lossfoodNotifier = ValueNotifier([]);

Future<void> foodadd(FoodModel data, int selectedgoal) async {
  final foodDB = await Hive.openBox<FoodModel>('gainfood');
  final foodDB2 = await Hive.openBox<FoodModel>('lossfood');

  if (selectedgoal == 1) {
    final id = await foodDB.add(data);
    final value = foodDB.get(id);
    await foodDB.put(
        id,
        FoodModel(
            name: value!.name,
            calorie: value.calorie,
            id: id,
            portion: value.portion));
    data.id = id;
    gainfoodNotifier.value.add(data);
    gainfoodNotifier.notifyListeners();
  } else {
    final id = await foodDB2.add(data);
    final value = foodDB2.get(id);
    await foodDB2.put(
        id,
        FoodModel(
            name: value!.name,
            calorie: value.calorie,
            id: id,
            portion: value.portion));
    data.id = id;
    lossfoodNotifier.value.add(data);
    lossfoodNotifier.notifyListeners();
  }
}

Future<void> getfoodlist() async {
  final foodDB = await Hive.openBox<FoodModel>('gainfood');
  final foodDB2 = await Hive.openBox<FoodModel>('lossfood');
  gainfoodNotifier.value.clear();
  lossfoodNotifier.value.clear();
  gainfoodNotifier.value.addAll(foodDB.values);
  lossfoodNotifier.value.addAll(foodDB2.values);
  gainfoodNotifier.notifyListeners();
  lossfoodNotifier.notifyListeners();
}

Future<void> deletefood(int id, int selectedgoal) async {
  final foodDB = await Hive.openBox<FoodModel>('gainfood');
  final foodDB2 = await Hive.openBox<FoodModel>('lossfood');

  if (selectedgoal == 1) {
    await foodDB.delete(id);
    getfoodlist();
  } else {
    await foodDB2.delete(id);
    getfoodlist();
  }
}

Future<void> clearHiveData() async {
  // Open the Hive box
  final box1 = await Hive.openBox<FoodModel>('gainfood');
  final box2 = await Hive.openBox<FoodModel>('lossfood');
  final box3 = await Hive.openBox<FoodModel>('Breakfast');
  final box4 = await Hive.openBox<FoodModel>('Lunch');
  final box5 = await Hive.openBox<FoodModel>('Dinner');
  gainfoodNotifier.value.clear();
  lossfoodNotifier.value.clear();
  breakfastnotifier.value.clear();
  lunchnotifier.value.clear();
  dinnernotifier.value.clear();

  // Clear all the data in the box
  await box1.clear();
  await box2.clear();
  await box3.clear();
  await box4.clear();
  await box5.clear();

  // Close the box
  await box1.close();
  await box2.close();
  await box3.close();
  await box4.close();
  await box5.close();
}
