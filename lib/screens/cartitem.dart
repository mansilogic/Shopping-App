import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppingapp/models/nodes_model.dart';
import 'package:shoppingapp/boxes/boxes.dart';

class CartItems extends StatefulWidget {
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  final productNameController = TextEditingController();
  String selectedProduct = '';
  int selectedProductPrice = 0;
  
  int quantity = 1;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _getProductNames();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: selectedProduct.isNotEmpty
                          ? selectedProduct
                          : 'Select a product',
                      hint: const Text('Select a product'),
                      onChanged: (String? newvalue) {
                        setState(() {
                          selectedProduct = newvalue!;
                          selectedProductPrice =
                              _getProductPrice(selectedProduct).toInt();
                          _updateTotal();
                          print(_productNames);
                          productNameController.text = selectedProduct;
                        });
                      },
                      items: _productNames.map((product) {
                        return DropdownMenuItem<String>(
                          value: product,
                          child: Text(product),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text('Price: \$${selectedProductPrice}'),
                    SizedBox(height: 20),
                    Text('Quantity:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                                _updateTotal();
                              });
                            }
                          },
                        ),
                        Text(quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                              _updateTotal();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Total: \$${total}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                       
                        AddToYourCart(selectedProduct,selectedProductPrice,quantity,total);
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _productNames = [];

  void _getProductNames() {
    final productBox = Hive.box<Product>('product');
    _productNames = productBox.values
        .map((product) => product.productName)
        .toSet()
        .toList();
  }

  Future<void> AddToYourCart(String selectedproduct, int selectedProductPrice,
      int quantity, int totalAmount) async {
  
    if (selectedProduct != 'Select a product' && quantity > 0) {
      final cartBox = Hive.box<CartItem>('addToCart');
      final cartItem = CartItem(
          cartProductName: selectedProduct,
          cartPrice: selectedProductPrice,
          cartQuantity: quantity,
          totalAmount: totalAmount);
      cartBox.add(cartItem);

      final values = cartBox.values;

                  for (var node in values) {
                    print('cartProductName: ${node.cartProductName}');
                    print('cartprice: ${node.cartPrice}');
                    print('quantity: ${node.cartQuantity}');
                    print('total: ${node.totalAmount}');
                  }
      setState(() {
        selectedProduct = 'Select a product';
        quantity=1;
        total = 0;
        selectedProductPrice=0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a valid product and quantity.'),
        ),
      );
    }
  }

  double _getProductPrice(String productName) {
    final productBox = Hive.box<Product>('product');
    try {
      final product = productBox.values.firstWhere(
        (product) => product.productName == productName,
        orElse: () => Product('', 0.0, 0),
      );
      return product.price;
    } catch (e) {
      print('Error while getting product price: $e');
      return 0;
    }
  }

  void _updateTotal() {
    total = selectedProductPrice * quantity;
    setState(() {});
  }
}
