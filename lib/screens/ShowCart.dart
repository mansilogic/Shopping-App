import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppingapp/models/nodes_model.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({super.key});

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialApp(
            theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
          home: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                       
                      });
                       
                    },
                  ),
                ),
              ),
              ValueListenableBuilder<Box<CartItem>>(
                  valueListenable: Hive.box<CartItem>('addToCart').listenable(),
                  builder: (context, box, _) {
                    box = Hive.box<CartItem>('addToCart');

                    var data = box.values.toList().cast<CartItem>();
                    final filteredData = data.where((item) {
                      final itemName = item.cartProductName.toLowerCase();
                      final query = searchController.text.toLowerCase();
                      return itemName.contains(query);
                      FocusScope.of(context).unfocus();
    
                    }).toList();
                    if (filteredData.isEmpty) {
                      return Padding(

                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 200),
                        child: Center(
                          child: Text('No items found.',style: TextStyle(fontSize: 23),),
                        
                        ),
                      );
                    }
                    return ListView.builder(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        reverse: true,
                        shrinkWrap: true,
                        
                        itemCount: filteredData.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            
                            child: Card(
                              elevation: 10,
                              color: Color.fromARGB(255, 207, 247, 209),
                              margin: EdgeInsets.all(10),
                              child: SizedBox(
                                height: 90,
                                width: 20,
                                
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      
                                      children: [
                                        Text(
                                          'Product Name :',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            filteredData[index]
                                                .cartProductName
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          onPressed: () {
                                            delete(filteredData[index]);
                                          },
                                          icon: Icon(Icons.delete),
                                          // child: const Icon(Icons.delete)
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Total Amount :',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          filteredData[index]
                                              .totalAmount
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }),
            ],
          ),
        ));
  }

  void delete(CartItem cartItem) {
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
