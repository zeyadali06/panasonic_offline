// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Panasonic_offline/components/helper.dart';
import 'package:Panasonic_offline/constants.dart';
import 'package:Panasonic_offline/main.dart';
import 'package:Panasonic_offline/models/ProductModel.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String deviceName = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 50,
          width: 80,
          child: MaterialButton(
            onPressed: () {
              Provider.of<ProviderVariables>(context, listen: false).product = null;
              Navigator.pushNamed(context, 'AddProductPage');
            },
            shape: RoundedRectangleBorder(borderRadius: KRadius),
            color: Theme.of(context).primaryColor,
            child: const Text('New Device', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          ),
        ),
        appBar: AppBar(backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
        body: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.all(KHorizontalPadding),
              child: TextField(
                onChanged: (data) {
                  deviceName = data.toUpperCase().trim();
                  setState(() {});
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Enter device name',
                ),
              ),
            ),

            // Devices List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(allProductsCollection).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    try {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          if (document.id.contains(deviceName)) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding, vertical: 8),
                                  child: CustomButton(
                                    onTap: () {
                                      Provider.of<ProviderVariables>(context, listen: false).product = ProductModel.fromFireStoreDB(data);
                                      Navigator.pushNamed(context, 'AddProductPage');
                                    },
                                    widget: Text(data['model'], style: const TextStyle(fontSize: 22)),
                                    color: Theme.of(context).buttonTheme.colorScheme!.background,
                                    borderColor: Theme.of(context).buttonTheme.colorScheme!.outline,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Column();
                          }
                        }).toList(),
                      );
                    } catch (e) {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
