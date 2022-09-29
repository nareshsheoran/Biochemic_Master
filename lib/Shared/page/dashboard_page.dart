import 'package:biochemic_master/Shared/constant.dart';
import 'package:biochemic_master/page/search_page/search_page.dart';
import 'package:flutter/material.dart';

import '../../page/remedies_page/medicine_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  List<Widget> tabPage = [
    const MedicinePage(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(appName),
        centerTitle: true,
        backgroundColor: Constant.primaryColor,
      ),
      body: IndexedStack(index: _selectedIndex, children: tabPage),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Constant.primaryColor,
      selectedFontSize: 18,
      unselectedFontSize: 12,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      selectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      currentIndex: _selectedIndex,
      onTap: onTabSelect,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
      ],
    );
  }

  void onTabSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
