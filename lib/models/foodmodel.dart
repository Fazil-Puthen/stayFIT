import 'package:hive/hive.dart';
// import 'package:flutter/material.dart';
part 'foodmodel.g.dart';

@HiveType(typeId: 0)
class FoodModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String portion;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double calorie;

  @HiveField(4)
  String? imagepath;

  FoodModel(
      {required this.name,
      required this.calorie,
      this.id,
      required this.portion,
      this.imagepath});
}
