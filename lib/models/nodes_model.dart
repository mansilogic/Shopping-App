import 'package:hive/hive.dart';
part 'nodes_model.g.dart';

@HiveType(typeId: 0)
class NodesModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  NodesModel(this.name, this.phoneNumber, this.email, this.password);
  NodesModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        phoneNumber = map['phoneNumber'],
        email = map['email'],
        password = map['password'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phoneNumber,
      'email': email,
      'password': password
    };
  }
}

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String productName;
  @HiveField(1)
  late double price;
  @HiveField(2)
  late int quantity;

  Product(this.productName, this.price, this.quantity);

  Product.fromMap(Map<String, dynamic> map)
      : productName = map['productName'],
        price = map['price'],
        quantity = map['quantity'];

  Map<String, dynamic> toMap() {
    return {'productName': productName, 'price': price, 'quantity': quantity};
  }
}

@HiveType(typeId: 2)
class CartItem extends HiveObject {
  @HiveField(0)
  final String cartProductName;
  @HiveField(1)
  final int cartPrice;
  @HiveField(2)
  final int cartQuantity;
  @HiveField(3)
  final double totalAmount;

  CartItem(
      {required this.cartProductName,
      required this.cartPrice,
      required this.cartQuantity,
      required this.totalAmount});
      

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cartProductName: map['cartProductName'] ?? '',
      cartPrice: map['cartPrice'] ?? 0.0,
      cartQuantity: map['cartQuantity'] ?? 0,
      totalAmount: map['totalAmount'] ?? 0.0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'cartProductName': cartProductName,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'totalAmount': totalAmount
    };
  }
}
