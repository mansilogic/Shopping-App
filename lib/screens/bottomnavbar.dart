// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/screens/cartitem.dart';
import 'package:shoppingapp/screens/homepage.dart';
import 'package:shoppingapp/screens/login.dart';
import 'package:shoppingapp/screens/manageproduct.dart';

void main() => runApp(const BottomNavigationApp());

class BottomNavigationApp extends StatelessWidget {
  const BottomNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'JUST DO SHOPPING',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                  ),
                  title: const Text('Log Out'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.train,
                  ),
                  title: const Text('Page 2'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_outlined),
              label: 'Cart',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: 'Manage',
              backgroundColor: Colors.green,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
   CartItem(),
    const Center(
      child: Text(
        'Cart',
        style: optionStyle,
      ),
    ),
    const ManageProduct(),
  ];
}
