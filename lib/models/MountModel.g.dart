// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MountModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MountModelAdapter extends TypeAdapter<MountModel> {
  @override
  final int typeId = 2;

  @override
  MountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MountModel(
      id: fields[0] as String,
      date: fields[1] as String,
      akaryakit: fields[5] as String,
      alisveris: fields[2] as String,
      elektronik: fields[4] as String,
      kalan: fields[7] as double,
      kira: fields[6] as String,
      fatura: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MountModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.alisveris)
      ..writeByte(3)
      ..write(obj.fatura)
      ..writeByte(4)
      ..write(obj.elektronik)
      ..writeByte(5)
      ..write(obj.akaryakit)
      ..writeByte(6)
      ..write(obj.kira)
      ..writeByte(7)
      ..write(obj.kalan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
