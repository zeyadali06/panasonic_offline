// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      model: fields[0] as String,
      description: fields[1] as String,
      category: fields[2] as String,
      used: fields[3] as bool,
      price: fields[4] as double?,
      quantity: fields[5] as int?,
      image: fields[6] as String?,
      abbreviation: fields[7] as String?,
      compatibility: (fields[8] as List?)?.cast<dynamic>().toSet(),
      note: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.used)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.abbreviation)
      ..writeByte(8)
      ..write(obj.compatibility?.toList())
      ..writeByte(9)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
