// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailymodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyModelAdapter extends TypeAdapter<DailyModel> {
  @override
  final int typeId = 1;

  @override
  DailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyModel(
      id: fields[0] as int?,
      day: fields[1] as int,
      breakfast: fields[2] as double,
      lunch: fields[3] as double,
      dinner: fields[4] as double,
      dailytotal: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DailyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.breakfast)
      ..writeByte(3)
      ..write(obj.lunch)
      ..writeByte(4)
      ..write(obj.dinner)
      ..writeByte(5)
      ..write(obj.dailytotal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
