import 'package:hive/hive.dart';
part 'dailymodel.g.dart';

@HiveType(typeId: 1)
class DailyModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final int day;

  @HiveField(2)
  final double breakfast;

  @HiveField(3)
  final double lunch;

  @HiveField(4)
  final double dinner;

  @HiveField(5)
  final double dailytotal;

  DailyModel(
      {this.id,
      required this.day,
      required this.breakfast,
      required this.lunch,
      required this.dinner,
      required this.dailytotal});
}
