// ignore_for_file: file_names

import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductStates.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:Panasonic_offline/services/HiveServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductCubit extends Cubit<Edit> {
  EditProductCubit() : super(EditNotFinish());

  Future<void> editting(ProductModel product) async {
    try {
      for (var element in getData()) {
        if (element.used == product.used && element.model == product.model) {
          element.copy(product);
          await editData(element);
          emit(StoringSuccess());
          break;
        }
      }
    } catch (_) {
      emit(StoringFailed());
    }
  }
}
