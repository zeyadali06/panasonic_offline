// ignore_for_file: file_names

import 'dart:async';
import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductCubit.dart';
import 'package:Panasonic_offline/cubits/EditingProduct/EditingProductStates.dart';
import 'package:Panasonic_offline/services/HiveServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/main.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductCubit, Edit>(
      listener: (context, state) {
        if (state is StoringSuccess) {
          setState(() {});
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: const Text('My Products', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: () async {
                    Provider.of<ProviderVariables>(context, listen: false).product = null;
                    var res = await Navigator.pushNamed(context, 'AddProductPage');
                    if (res != null && res == 'poped') {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white))
            ],
          ),
          body: StreamBuilder<ProductModelSnapshot>(
            stream: dataToStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading . . .', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
              } else if (snapshot.data!.length == 0) {
                return const Center(child: Text('No Devices Found', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
              } else {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.allProducts.map((element) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: 8),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: kRadius),
                            child: ListTile(
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Delete Product ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                                  Icon(Icons.delete, color: Colors.white),
                                ],
                              ),
                              tileColor: Colors.red,
                              shape: RoundedRectangleBorder(side: const BorderSide(width: 0, color: Colors.red), borderRadius: kRadius),
                            ),
                          ),
                          Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              isLoading = true;
                              setState(() {});
                              await deleteData(element);
                              isLoading = false;
                              setState(() {});
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: kRadius),
                              child: ListTile(
                                onTap: () async {
                                  // Provider.of<ProviderVariables>(context, listen: false).product = ProductModel.init();
                                  Provider.of<ProviderVariables>(context, listen: false).product = element;
                                  var res = await Navigator.pushNamed(context, 'EditOrDeleteProductPage', arguments: element);
                                  if (res != null && res == 'poped') {
                                    setState(() {});
                                  }
                                },
                                shape: RoundedRectangleBorder(side: BorderSide(width: 0, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: kRadius),
                                tileColor: Theme.of(context).buttonTheme.colorScheme!.background,
                                leading: Text(element.model, style: const TextStyle(fontSize: 22)),
                                title: element.price == null ? null : Center(child: Text("${element.price}£E", style: const TextStyle(fontSize: 22))),
                                trailing: Text(element.used ? 'used' : ''),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Stream<ProductModelSnapshot> dataToStream() {
  StreamController<ProductModelSnapshot> controller = StreamController();
  ProductModelSnapshot products = ProductModelSnapshot();
  products.allProducts = getData();
  products.length = products.allProducts.length;
  controller.add(products);
  return controller.stream;
}

class ProductModelSnapshot {
  late List<ProductModel> allProducts;
  late int length;
  ProductModelSnapshot() {
    allProducts = [];
    length = 0;
  }
}
