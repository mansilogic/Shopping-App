import 'package:hive/hive.dart';
import 'package:shoppingapp/models/nodes_model.dart';

class Boxes{

  static Box<NodesModel> getData() =>Hive.box<NodesModel>('notes');
 }

class ProductBox {
   static Box<Product> getData()=>Hive.box<Product>('product');
}