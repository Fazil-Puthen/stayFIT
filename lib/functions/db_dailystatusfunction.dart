import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/dailymodel.dart';


ValueNotifier<List<DailyModel>> dailynotifier = ValueNotifier([]);

Future<void> addtodailylist(DailyModel data) async {
  final dailydata = await Hive.openBox<DailyModel>('dailystatus');
  final id = await dailydata.add(data);
  final value = dailydata.get(id);
  await dailydata.put(
      id,
      DailyModel(
          day: value!.day,
          breakfast: value.breakfast,
          lunch: value.lunch,
          dinner: value.dinner,
          dailytotal: value.dailytotal,
          id: id));
  data.id = id;
  dailynotifier.value.add(data);
  dailynotifier.notifyListeners();
}

Future<void> cleardailystatus() async {
  final dailydata = await Hive.openBox<DailyModel>('dailystatus');
  dailynotifier.value.clear();
  dailynotifier.notifyListeners();
  await dailydata.clear();
}
