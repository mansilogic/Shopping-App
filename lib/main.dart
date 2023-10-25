import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoppingapp/screens/login.dart';
import 'package:shoppingapp/screens/signup.dart';

import 'models/nodes_model.dart';

void main() async {
  
  await Hive.initFlutter();
 // WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NodesModelAdapter());
  await Hive.openBox<NodesModel>('notes');

  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('product');

  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('addToCart');

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'JUST DO SHOPPING',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello There!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Automatic identity verification which enable you to verify your identity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade100,
                            Colors.grey.shade100
                          ]),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/logo.jpg'))),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        color: const Color.fromARGB(255, 39, 216, 98),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: const Text('SIGN UP',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black))),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        color: const Color.fromARGB(255, 39, 216, 98),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()),
                          );
                        },
                        child: const Text('LOG IN',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
