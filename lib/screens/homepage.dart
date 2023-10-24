
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/bottomnavbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const BottomNavigationApp());
    
  }
}