import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppingapp/models/nodes_model.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({super.key});

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  final searchController = TextEditingController(); // Step 1: TextEditingController for search

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
          actions: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                // Clear the search query and refresh the list
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search for items',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Step 2: Filter the items based on the search query
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<CartItem>>(
                valueListenable: Hive.box<CartItem>('addToCart').listenable(),
                builder: (context, box, _) {
                  box = Hive.box<CartItem>('addToCart');

                  var data = box.values.toList().cast<CartItem>();

                  // Step 2: Filter the items based on the search query
                  final filteredData = data.where((item) {
                    final itemName = item.cartProductName.toLowerCase();
                    final query = searchController.text.toLowerCase();
                    return itemName.contains(query);
                  }).toList();

                  return ListView.builder(
                    reverse: false,
                    shrinkWrap: true,
                    itemCount: filteredData.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      filteredData[index].cartProductName.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      delete(filteredData[index]);
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                              Text(
                                filteredData[index].totalAmount.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void delete(CartItem cartItem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete the product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await cartItem.delete();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
