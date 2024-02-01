// ignore_for_file: file_names

import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:hive/hive.dart';

Future<void> addData(ProductModel product) async {
  await Hive.box<ProductModel>(kProductsBox).add(product);
}

List<ProductModel> getData() {
  return Hive.box<ProductModel>(kProductsBox).values.toList();
}

Future<void> deleteData(ProductModel product) async {
  await product.delete();
}

Future<void> editData(ProductModel product) async {
  await product.save();
}
