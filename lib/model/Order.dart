import 'package:app1/model/Support.dart';
import 'package:app1/model/UserOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  num amount;
  num deliveryCharge;
  num totalOrderCost;
  List<String> usersOrders;
  DateTime date;
  String resturant;
  Order(
      {this.id,
      this.amount,
      this.deliveryCharge,
      this.totalOrderCost,
      this.usersOrders,
      this.date,this.resturant});
  Order.fromDocument(DocumentSnapshot doc) {
    if (doc.exists) {
      this.id = doc.documentID;
      this.amount = doc.data["amount"];
      this.deliveryCharge = doc.data["deliveryCharge"];
      this.totalOrderCost = doc.data["totalOrderCost"];
      this.date =  (doc.data["date"]);
      this.resturant =  (doc.data["resturant"]);
      // this.deliveryCostPerUser = doc.data["deliveryCostPerUser"];
      //  this.paied = doc.data["paied"];
    }
  }
  toJson() {
    return{
        "amount": amount,
        "deliveryCharge": deliveryCharge,
        "totalOrderCost": totalOrderCost,
        "date": date,
        "resturant":resturant

    };
    
   
    
     
    
   }
}
