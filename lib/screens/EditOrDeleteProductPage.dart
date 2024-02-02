// ignore_for_file: file_names

import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductCubit.dart';
import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductStates.dart';
import 'package:Panasonic_offline/services/HiveServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:number_editing_controller/number_editing_controller.dart';
import 'package:Panasonic_offline/components/helper.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/main.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:provider/provider.dart';

class EditOrDeleteProductPage extends StatefulWidget {
  const EditOrDeleteProductPage({super.key});

  @override
  State<EditOrDeleteProductPage> createState() => _EditOrDeleteProductPageState();
}

class _EditOrDeleteProductPageState extends State<EditOrDeleteProductPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel editted = ModalRoute.of(context)!.settings.arguments as ProductModel;
    ProductModel product = ProductModel.init();
    product.copy(editted);

    return BlocListener<EditProductCubit, Edit>(
      listener: (context, state) async {
        if (state is StoringSuccess) {
          showSnackBar(context, state.message);
          Navigator.pop(context);
        } else if (state is StoringFailed) {
          showSnackBar(context, state.message);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: PopScope(
            onPopInvoked: (popInvoked) {
              if (popInvoked) {
                Provider.of<ProviderVariables>(context, listen: false).product = null;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                centerTitle: true,
                title: const Text('Edit Product', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                automaticallyImplyLeading: false,
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(kHorizontalPadding),
                children: [
                  // Device Model
                  const Text('Device Model', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    hintText: product.model,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    hintText: product.description,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),

                  // Category
                  const Text('Category', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 5),
                  CustomDropdownButton(
                    enabled: false,
                    initialText: product.category,
                    thingsToDisplay: [product.category],
                    onSelected: (value) {},
                  ),
                  const SizedBox(height: 20),

                  // Used
                  Row(
                    children: [
                      const Text('Used', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
                      Checkbox(value: product.used, onChanged: (value) {}, activeColor: Theme.of(context).checkboxTheme.overlayColor!.resolve({})!),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Price
                  const Text('Price', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    onChanged: (data) {
                      try {
                        data = data.replaceAll('EGP', '').replaceAll(',', '');
                        if (data == '') {
                          product.price = null;
                        } else {
                          product.price = double.parse(data);
                        }
                      } catch (_) {}
                    },
                    hintText: 'Enter Price',
                    suffixText: 'EGP',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                      FilteringTextInputFormatter.deny(RegExp(' ')),
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]*\.?[0-9]*")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (oldValue.text == '' && newValue.text == '.') {
                          return const TextEditingValue(text: '0.');
                        } else {
                          return newValue;
                        }
                      }),
                    ],
                    controller: NumberEditingTextController.decimal(
                      value: product.price,
                      allowNegative: false,
                      maximumFractionDigits: 2,
                      groupSeparator: ',',
                      decimalSeparator: '.',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quantity
                  const Text('Quantity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    onChanged: (data) {
                      try {
                        data = data.replaceAll(',', '');
                        if (data == '') {
                          product.quantity = null;
                        } else {
                          product.quantity = int.parse(data);
                        }
                      } catch (_) {}
                    },
                    hintText: 'Enter Quantity',
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    controller: NumberEditingTextController.integer(value: product.quantity, allowNegative: false),
                  ),
                  const SizedBox(height: 20),

                  // Abbreviation
                  const Text('Abbreviation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    onChanged: (data) {
                      product.abbreviation = data.trim().toUpperCase();
                    },
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.deny(RegExp(' ')),
                      LengthLimitingTextInputFormatter(15),
                    ],
                    hintText: 'Enter Device Abbreviation',
                    controller: TextEditingController(text: product.abbreviation),
                  ),
                  const SizedBox(height: 20),

                  // Compatibility
                  const Text('Compatibility', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  ChooseAndShowCompatibleDevices(allCompatibleDevices: allCompatibleDevices, product: product),
                  const SizedBox(height: 20),

                  // Note
                  const Text('Notes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TFForAddProduct(
                    onChanged: (data) {
                      product.note = data.trim();
                    },
                    multiLine: true,
                    hintText: '',
                    controller: TextEditingController(text: product.note),
                  ),
                  const SizedBox(height: 20),

                  // Save Changes
                  CustomButton(
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      FocusManager.instance.primaryFocus?.unfocus();
                      await BlocProvider.of<EditProductCubit>(context).editting(product);
                    },
                    widget: textOfCustomButton(text: 'Save Changes'),
                    color: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 10),

                  // Delete Product
                  CustomButton(
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      editted.copy(product);
                      await deleteData(editted);
                      showSnackBar(context, 'Product Deleted Successfully');
                      // Provider.of<ProviderVariables>(context, listen: false).product = null;
                      Navigator.pop(context);
                    },
                    widget: textOfCustomButton(text: 'Delete Product'),
                    color: Colors.red,
                    borderColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
