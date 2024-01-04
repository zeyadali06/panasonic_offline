// ignore_for_file: file_names

import 'package:Panasonic_offline/services/HiveServices.dart';
import 'package:flutter/material.dart';
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
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          title: const Text('My Products', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<ProviderVariables>(context, listen: false).product = null;
                  Navigator.pushNamed(context, 'AddProductPage');
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Builder(
          builder: (context) {
            List<ProductModel> myProducts = [];

            try {
              myProducts = getData();
              if (myProducts.isEmpty) {
                return const Center(child: Text('No Devices Found', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
              }

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: myProducts.map((element) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding, vertical: 8),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: KRadius),
                          child: ListTile(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Delete Product ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                                Icon(Icons.delete, color: Colors.white),
                              ],
                            ),
                            tileColor: Colors.red,
                            shape: RoundedRectangleBorder(side: const BorderSide(width: 0, color: Colors.red), borderRadius: KRadius),
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
                            shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: KRadius),
                            child: ListTile(
                              onTap: () {
                                isLoading = true;
                                setState(() {});
                                ProductModel ele;
                                ele.copy(element);
                                Provider.of<ProviderVariables>(context, listen: false).product = ele;
                                Navigator.pushNamed(context, 'EditOrDeleteProductPage');
                                isLoading = false;
                                setState(() {});
                              },
                              shape: RoundedRectangleBorder(side: BorderSide(width: 0, color: Theme.of(context).buttonTheme.colorScheme!.outline), borderRadius: KRadius),
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
            } catch (e) {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
