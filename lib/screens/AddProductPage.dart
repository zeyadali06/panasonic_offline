// ignore_for_file: file_names
import 'package:Panasonic_offline/services/HiveServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:number_editing_controller/number_editing_controller.dart';
import 'package:Panasonic_offline/components/helper.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/main.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void deactivate() {
    Provider.of<ProviderVariables>(context, listen: false).product = null;
    super.deactivate();
  }

  bool isLoading = false;
  bool isChecked = false;

  ScrollController scrollController = ScrollController();

  final TextEditingController modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductModel product = Provider.of<ProviderVariables>(context, listen: false).product == null ? ProductModel.init() : Provider.of<ProviderVariables>(context, listen: false).product!;

    product.category = 'Air Conditioning';

    if (product.model != '') {
      modelController.text = product.model;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: const Text('Add Product', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            automaticallyImplyLeading: false,
          ),
          body: Form(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.all(kHorizontalPadding),
              children: [
                // Device Model
                const LabelWithRedStar(label: 'Device Model'),
                const SizedBox(height: 5),
                TFForAddProduct(
                  hintText: 'Enter Device Model',
                  onChanged: (data) {
                    product.model = data.toUpperCase().trim();
                  },
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.deny(RegExp(' ')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  controller: modelController,
                ),
                const SizedBox(height: 20),

                // Description
                const LabelWithRedStar(label: 'Description'),
                const SizedBox(height: 5),
                TFForAddProduct(
                  hintText: 'Enter Device Description',
                  onChanged: (data) {
                    product.description = data;
                  },
                ),
                const SizedBox(height: 20),

                // Category
                const LabelWithRedStar(label: 'Category Of Device'),
                const SizedBox(height: 5),
                CustomDropdownButton(
                  initialText: allCategories.first,
                  thingsToDisplay: allCategories.toList(),
                  onSelected: (value) {
                    product.category = value!;
                  },
                ),
                const SizedBox(height: 10),

                // Used
                Row(
                  children: [
                    const LabelWithRedStar(label: 'Used'),
                    CustomCheckbox(
                      activeColor: Theme.of(context).checkboxTheme.overlayColor!.resolve({})!,
                      initialValue: isChecked,
                      onChanged: (value) {
                        isChecked = value;
                        product.used = isChecked;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(' ')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  hintText: 'Enter Quantity',
                  controller: NumberEditingTextController.integer(allowNegative: false),
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
                ),
                const SizedBox(height: 20),

                // Compatibility
                const Text('Compatibility', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                ChooseAndShowCompatibleDevices(product: product, allCompatibleDevices: allCompatibleDevices.toSet()),
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
                ),
                const SizedBox(height: 20),

                // Add Product
                CustomButton(
                  onTap: () async {
                    if (product.model == '') {
                      showSnackBar(context, 'Device model is empty');
                      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                      return;
                    }
                    if (product.description == '') {
                      showSnackBar(context, 'Device description is empty');
                      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                      return;
                    }
                    isLoading = true;
                    setState(() {});
                    FocusManager.instance.primaryFocus?.unfocus();
                    await sendtoHive(context, product);
                  },
                  widget: textOfCustomButton(text: 'Add Product'),
                  color: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),

                // Clear All
                CustomButton(
                  onTap: () {
                    Provider.of<ProviderVariables>(context, listen: false).product = null;
                    Navigator.pushReplacementNamed(context, 'AddProductPage');
                  },
                  widget: textOfCustomButton(text: 'Clear All'),
                  color: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> sendtoHive(BuildContext context, ProductModel product) async {
  try {
    bool exist = false;
    late ProductModel old;
    for (var element in getData()) {
      if (element.used == product.used && element.model == product.model) {
        exist = true;
        old = element;
        break;
      }
    }

    if (exist) {
      old.copy(product);
      await editData(old);
    } else {
      await addData(product);
    }

    showSnackBar(context, 'Product Added Successfully');
    Provider.of<ProviderVariables>(context, listen: false).product = null;
    Navigator.pop(context);
  } catch (e) {
    showSnackBar(context, 'Error, try again');
  }
}
