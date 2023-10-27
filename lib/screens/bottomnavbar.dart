// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/models/nodes_model.dart';
import 'package:shoppingapp/screens/ShowCart.dart';
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
      home: BottomNavigation(
        userEmail: '',
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final String userEmail;
  const BottomNavigation({super.key, required String? userEmail})
      : userEmail = userEmail ?? '';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  late final String userEmail;

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
                Container(
                  height: 120,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      'do shopping',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: Text(
                    widget.userEmail,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                  ),
                  title: const Text('Log Out'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirm Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancle'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  _handleLogout();
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          );
                        });
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
    CartItems(),
    ShowCart(),
    const ManageProduct(),
  ];
  void _handleLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
      (route) => false, 
    );
  }
}
