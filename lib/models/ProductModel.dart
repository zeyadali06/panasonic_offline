// ignore_for_file: file_names

import 'package:hive/hive.dart';
part 'ProductModel.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  String model;

  @HiveField(1)
  String description;

  @HiveField(2)
  String category;

  @HiveField(3)
  bool used;

  @HiveField(4)
  double? price;

  @HiveField(5)
  int? quantity;

  @HiveField(6)
  String? image;

  @HiveField(7)
  String? abbreviation;

  @HiveField(8)
  Set? compatibility;

  @HiveField(9)
  String? note;

  ProductModel({
    required this.model,
    required this.description,
    required this.category,
    required this.used,
    this.price,
    this.quantity,
    this.image,
    this.abbreviation,
    this.compatibility,
    this.note,
  });

  factory ProductModel.fromFireStoreDB(dynamic data) {
    return ProductModel(
      model: data['model'],
      description: data['description'],
      category: data['category'],
      used: data['used'],
      price: data['price'],
      quantity: data['quantity'],
      image: data['image'],
      abbreviation: data['abbreviation'],
      compatibility: data['compatibility'] == null ? null : data['compatibility'].toSet(),
      note: data['note'],
    );
  }

  void copy(ProductModel product) {
    abbreviation = product.abbreviation;
    category = product.category;
    compatibility = product.compatibility;
    description = product.description;
    image = product.image;
    model = product.model;
    note = product.note;
    price = product.price;
    quantity = product.quantity;
    used = product.used;
  }

  @override
  String toString() {
    return "Model: $model\nDescription: $description\nCategory: $category\nUsed: $used\nPrice: $price\nQuantity: $quantity\nImage: $image\nAbbreviation: $abbreviation\nCompatibility: $compatibility\nNote: $note";
  }
}
