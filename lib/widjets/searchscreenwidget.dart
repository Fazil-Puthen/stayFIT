//search screen function

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:flutter/material.dart';

import '../functions/db_mealfunctions.dart';
import '../models/foodmodel.dart';

Widget searchScreen(FoodModel data, int index, String mealtime) {
  final base64image = data.imagepath;
  final imagedecoded = base64Decode(base64image!);
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: MemoryImage(imagedecoded)
                  
            ),
            Column(
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  ' ${data.calorie} calorie',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            Text(data.portion),
            IconButton(
                onPressed: () {
                  final meal = FoodModel(
                      name: data.name,
                      calorie: data.calorie,
                      portion: data.portion);
                  addmealtime(meal, mealtime);
                },
                icon: const Icon(Icons.add))
            // ValueListenableBuilder(
            //     valueListenable: count,
            //     builder: (ctx, int value, _) {
            //       return Row(children: [
            //         IconButton(
            //             onPressed: () {
            //               add(count, data, index, caloriechange);
            //               print('this is the count $value');
            //             },
            //             icon: const Icon(
            //               Icons.add,
            //               color: Colors.blue,
            //             )),
            //         Text(
            //           '${value.toString()} portion',
            //           style: const TextStyle(fontSize: 15),
            //         ),
            //         IconButton(
            //           onPressed: () {
            //             sub(count, data, caloriechange);
            //           },
            //           icon: const Icon(
            //             Icons.delete,
            //             color: Colors.red,
            //           ),
            //         )
            //       ]);
            //     })
          ],
        ),
      ),
    ),
  );
}

void add(ValueNotifier<int> count, FoodModel data, int index,
    ValueNotifier<double> caloriechange) {
  if (count.value >= 0) {
    count.value++;
    if (count.value >= 2) {
      caloriechange.value = caloriechange.value + data.calorie;
      // ignore: invalid_use_of_protected_member
      caloriechange.notifyListeners();
    }
  }
}

void sub(ValueNotifier<int> count, FoodModel data,
    ValueNotifier<double> caloriechange) {
  if (count.value > 0) {
    count.value--;
    if (count.value >= 1) {
      caloriechange.value = caloriechange.value - data.calorie;
      caloriechange.notifyListeners();
    }
  }
}
