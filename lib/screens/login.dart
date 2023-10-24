import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:shoppingapp/screens/homepage.dart';
import 'package:shoppingapp/screens/manageproduct.dart';

import '../models/nodes_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Log In",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "carefully Enter Data !!",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'E-Mail',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                           const SizedBox(width: 10), // Add some spacing
                              
                                      ],
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                                 !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value))  {
                                          return "Enter Proper Email";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                      
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Password',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                           const SizedBox(width: 10), // Add some spacing
                              
                                      ],
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        
                                      },
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                      
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  _loginFunction();
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),),
                ],
                  ),],
              ),
            ),
          ),
        ),
      ),
    );
  }
void _loginFunction() async {
  final nodeBox = await Hive.openBox<NodesModel>('notes');

  final email = emailController.text;
  final password = passwordController.text;

  final users = nodeBox.values.where(
    (user) => user.email == email && user.password == password,
  );
  await nodeBox.close();
  if (users.isNotEmpty) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Invalid email or password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

}
