import 'package:cloud_firestore/cloud_firestore.dart';

class support {
  static Firestore firebase = Firestore.instance;
  static CollectionReference TabelUser = firebase.collection("users");
  static CollectionReference TabelOrder = firebase.collection("order");
  static CollectionReference TabelUserOrder = firebase.collection("userOrder");
  static CollectionReference TabelResturant = firebase.collection("resturant");
}
