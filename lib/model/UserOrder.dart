import 'package:app1/model/Support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  String id;
  String User_id;
  String Order_id;
  num orderCost; //order cost to specific user
  num deliveryCostPerUser;
  num paied; //

  UserOrder(
      {this.User_id,
      this.Order_id,
      this.orderCost,
      this.deliveryCostPerUser,
      this.paied});
  UserOrder.fromDocument(DocumentSnapshot doc) {
    if (doc.exists) {
      this.id = doc.documentID;
      this.User_id = doc.data["User_id"];
      this.Order_id = doc.data["Order_id"];
      this.orderCost = doc.data["orderCost"];
      this.deliveryCostPerUser = doc.data["deliveryCostPerUser"];
      this.paied = doc.data["paied"];
    }
  }
  toJson() {
    return {
      "User_id": User_id,
      "Order_id": Order_id,
      "orderCost": orderCost,
      "deliveryCostPerUser": deliveryCostPerUser,
      " paied": paied,
    };
  }
}
