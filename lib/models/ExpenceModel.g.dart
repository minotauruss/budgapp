// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpenceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenceModelAdapter extends TypeAdapter<ExpenceModel> {
  @override
  final int typeId = 0;

  @override
  ExpenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenceModel(
      id: fields[0] as String,
      date: fields[1] as String,
      category: fields[2] as String,
      price: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
