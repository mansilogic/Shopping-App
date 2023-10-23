
import 'package:hive/hive.dart';
part 'nodes_model.g.dart';

@HiveType(typeId: 0)
class NodesModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  
  NodesModel(this.name,this.phoneNumber,this.email,this.password);

  NodesModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        phoneNumber=map['phoneNumber'],
        email=map['email'],
        password = map['password'];

  Map<String, dynamic> toMap() {
    return {'name':name,'phone':phoneNumber,'email': email, 'password': password};
  }
}