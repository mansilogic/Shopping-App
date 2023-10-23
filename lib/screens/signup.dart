import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shoppingapp/boxes/boxes.dart';
import 'package:shoppingapp/screens/login.dart';

import '../models/nodes_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';

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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                                      "Sign up",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Create an Account !!",
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
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                           const SizedBox(width: 10), // Add some spacing
                              
                                      ],
                                    ),
                                    TextFormField(
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[a-z A-Z]+$')
                                                .hasMatch(value)) {
                                          return "Enter Correct Name";
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
                                      onSaved: (value) => name = value!,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Phone Number',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                        ),
                                           const SizedBox(width: 10), // Add some spacing
                              
                                      ],
                                    ),
                                    TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null ||
                                            value.length != 10) {
                                          return 'Please enter phone number';
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
                                      onSaved: (value) => phoneNumber = value!,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Email',
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
                                                .hasMatch(value)) {
                                          return 'Enter a valid email!';
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
                                      onSaved: (value) => email = value!,
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
                                      ],
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        if (value.length < 3) {
                                          return 'Must be more than 2 Characters';
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
                                      onSaved: (value) => password = value!,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            _savedfunction();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LogIn(),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text('SIGN UP'))
                                  ]),
                                )
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
void _savedfunction() async {
  // Open the Hive box for your model
  final nodeBox = await Hive.openBox<NodesModel>('notes');
  
  // Create a new user with the data from the form
  final newUser = NodesModel(
    nameController.text,
    phoneController.text,
    emailController.text,
    passwordController.text,
  );

  // Add the new user to the Hive box
  await nodeBox.add(newUser);
 final values = nodeBox.values;

    for (var node in values) {
      print('Name: ${node.name}');
      print('Phone Number: ${node.phoneNumber}');
      print('Email: ${node.email}');
      print('Password: ${node.password}');
    }
  // You can also close the box when you're done
  await nodeBox.close();


}
}
