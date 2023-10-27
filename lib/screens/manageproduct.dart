// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shoppingapp/models/nodes_model.dart';
import 'package:shoppingapp/boxes/boxes.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();

  final price = '';
  final quantity = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ValueListenableBuilder<Box<Product>>(
            valueListenable: Hive.box<Product>('product').listenable(),
            builder: (context, box, _) {
              box = Hive.box<Product>('product');
              var data = box.values
                  .where((product) => product.productName != 'Select a product')
                  .toList()
                  .cast<Product>();

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                reverse: true,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return Container(
                    child: Card(
                      elevation: 10,
                      color: Color.fromARGB(255, 188, 241, 191),
                      margin: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 90,
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Product Name :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                  child: Text(
                                    data[index].productName.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                    onTap: () {
                                      if (data[index] != null) {
                                        _editDialog(
                                            data[index],
                                            data[index].productName.toString(),
                                            data[index].price.toString(),
                                            data[index].quantity.toString());
                                      }
                                    },
                                    child: const Icon(Icons.edit)),
                                const SizedBox(width: 15),
                                InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: const Icon(Icons.delete)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Product Price :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  data[index].price.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Product Quantity :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  data[index].quantity.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMyDialog();
            FocusScope.of(context).unfocus();
          },
          child: const Icon(Icons.add_task),
        ),
      ),
    );
  }

  Future<void> _editDialog(Product product, String productname, String price,
      String quantity) async {
    await Hive.openBox<Product>('product');
    productNameController.text = productname;
    priceController.text = price;
    quantityController.text = quantity;

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Product Data'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Product Name :',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Product Name";
                        } else {
                          return null;
                        }
                      },
                      controller: productNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Product Price :',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Price";
                        } else {
                          return null;
                        }
                      },
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Product Quantity:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Quantity";
                        } else {
                          return null;
                        }
                      },
                      controller: quantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      final price = double.tryParse(priceController.text);
                      final quantity = int.tryParse(quantityController.text);

                      if (price != null && quantity != null) {
                        product.productName = productNameController.text;
                        product.price = price;
                        product.quantity = quantity;
                        product.save();

                        productNameController.clear();
                        priceController.clear();
                        quantityController.clear();
                        FocusScope.of(context).unfocus();

                        Navigator.of(context).pop();
                      }
                      ;
                    }
                  },
                  child: const Text('Edit'))
            ],
          );
        });
  }

  void delete(Product product) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text('Are you sure you want to delete product?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancle'),
              ),
              TextButton(
                onPressed: () async {
                  await product.delete();
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }

  Future<void> _showMyDialog() async {
    productNameController.clear();
    priceController.clear();
    quantityController.clear();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Product'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Product Name :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Product Name";
                        } else {
                          return null;
                        }
                      },
                      controller: productNameController,
                      decoration: const InputDecoration(
                        hintText: 'Product Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Product Price :',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Price";
                        } else {
                          return null;
                        }
                      },
                      controller: priceController,
                      decoration: const InputDecoration(
                        hintText: 'Add Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Product Quantity :',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Add Quantity";
                        } else {
                          return null;
                        }
                      },
                      controller: quantityController,
                      decoration: const InputDecoration(
                        hintText: 'Add Quantity',
                        border: OutlineInputBorder(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  final FormState? form = _formKey.currentState;
                  if (form!.validate()) {
                    final price = double.tryParse(priceController.text);
                    final quantity = int.tryParse(quantityController.text);
                    if (price != null && quantity != null) {
                      final data = Product(
                        productNameController.text,
                        price,
                        quantity,
                      );

                      final box = Hive.box<Product>('product');
                      box.add(data);

                      final values = box.values;

                      for (var node in values) {
                        print('Name: ${node.productName}');
                        print('price: ${node.price}');
                        print('quantity: ${node.quantity}');
                      }
                    }
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  } else {}
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  productNameController.clear();
                  priceController.clear();
                  quantityController.clear();
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }
}
