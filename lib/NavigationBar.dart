// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:Panasonic_offline/screens/MyAccountPage.dart';
import 'package:Panasonic_offline/screens/MyProductsPage.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({super.key});

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int selectedIndex = 0;
  static List<Widget> pages = <Widget>[];

  void _refresh() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      const MyProductsPage(),
      SettingsPage(
        refresh: _refresh,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'My Products'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        onTap: _onItemTapped,
      ),
    );
  }
}



// zeyad@gmail.com

// 06062003


// zeyadali6060@gmail.com

// Ze06062003#


// set@gmail.com

// set.com