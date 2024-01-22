// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageModelAdapter extends TypeAdapter<StorageModel> {
  @override
  final int typeId = 0;

  @override
  StorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorageModel(
      storageplacename: fields[0] as String,
      description: fields[1] as String,
      itemcount: fields[2] as int,
      items: (fields[3] as List).cast<ItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StorageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.storageplacename)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.itemcount)
      ..writeByte(3)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 1;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      imagePath: fields[2] as String,
      itemName: fields[0] as String,
      itemDescription: fields[1] as String,
      time: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.itemDescription)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class editprofileAdapter extends TypeAdapter<editprofile> {
  @override
  final int typeId = 2;

  @override
  editprofile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return editprofile(
      imagePath: fields[4] as String,
      name: fields[0] as String,
      email: fields[1] as String,
      country: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, editprofile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is editprofileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
