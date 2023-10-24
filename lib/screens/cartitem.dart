import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppingapp/models/nodes_model.dart';
class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final productNameController = TextEditingController();
  String selectedProduct = '';
  double selectedProductPrice = 0.0;
  int quantity = 1;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    _getProductNames();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: selectedProduct,
            hint: Text('Select a product'),
            onChanged: (String? newvalue) {
              setState(() {
                selectedProduct = newvalue!;
                selectedProductPrice = _getProductPrice(selectedProduct).toDouble();
                _updateTotal();
              });
            },
            items: _productNames.map((product) {
              return DropdownMenuItem<String>(
                value: product,
                child: Text(product),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text('Price: \$${selectedProductPrice.toStringAsFixed(2)}'),
          SizedBox(height: 10),
          Text('Quantity:'),
          Row(
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
          Text('Total: \$${total.toStringAsFixed(2)}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _addToCart();
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  List<String> _productNames = [];

  void _getProductNames() {
    final productBox = Hive.box<Product>('product');
    _productNames = productBox.values.map((product) => product.productName).toList();
  }

  double _getProductPrice(String productName) {
    final productBox = Hive.box<Product>('product');
    final product = productBox.values.firstWhere(
      (product) => product.productName == productName,
      orElse: () => Product('', 0.0, 0),
    );
    return product.price;
  }

  void _updateTotal() {
    total = selectedProductPrice * quantity;
    setState(() {});
  }

  void _addToCart() {
  // final cartBox = Hive.box<CartItem>('addToCart');
  // final cartItem = CartItem(
  //   cartProductName: selectedProduct,
  //   cartPrice: selectedProductPrice,
  //   cartQuantity: quantity,
  //   totalAmount: total,
  // );
  // cartBox.add(cartItem);
}

}
