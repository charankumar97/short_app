// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      title: fields[0] as String,
      sellPrice: fields[1] as double,
      id: fields[2] as int,
      sku: fields[3] as String,
      qty: fields[4] as int,
      total: fields[6] as double,
      finalPrice: fields[5] as double,
      image: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.sellPrice)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.sku)
      ..writeByte(4)
      ..write(obj.qty)
      ..writeByte(5)
      ..write(obj.finalPrice)
      ..writeByte(6)
      ..write(obj.total)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
