import 'package:app1/model/support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class User {
  String id;
  String pass;
  String firstName;
  String lastName;
  String username; //is unique
  num amount;
  bool admin=false;
  User(
      {this.id,
      this.pass,
      this.firstName,
      this.lastName,
      this.username,
      this.amount,
      this.admin});

  User.fromDocument(DocumentSnapshot doc) {
    print(doc.data);

    if (doc.exists) {
      this.id = doc.documentID;
      this.pass = doc.data["pass"];
      this.firstName = doc.data["firstName"];
      this.lastName = doc.data["lastName"];
      this.username = doc.data["username"];
      this.amount = doc.data["amount"];
      this.admin = doc.data["admin"];
    }
  }
  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "pass": pass,
      "username": username,
      "amount": amount,
      "admin": admin,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id $id pass $pass name $firstName  $lastName username $username amunt $amount";
  }
}
