// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InfoModels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoModelsAdapter extends TypeAdapter<InfoModels> {
  @override
  final int typeId = 4;

  @override
  InfoModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoModels(
      id: fields[0] as String,
      maas: fields[1] as double,
      kira: fields[2] as double,
      netMaas: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InfoModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.maas)
      ..writeByte(2)
      ..write(obj.kira)
      ..writeByte(3)
      ..write(obj.netMaas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
