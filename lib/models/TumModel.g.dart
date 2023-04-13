// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TumModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TumModelAdapter extends TypeAdapter<TumModel> {
  @override
  final int typeId = 1;

  @override
  TumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TumModel(
      id: fields[0] as String,
      date: fields[1] as String,
      category: fields[2] as String,
      price: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TumModel obj) {
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
      other is TumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
