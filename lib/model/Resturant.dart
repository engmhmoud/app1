import 'package:cloud_firestore/cloud_firestore.dart';

class Resturant {
  String id;
  String name;

  Resturant({this.id, this.name });
  Resturant.fromDocument(DocumentSnapshot doc) {
    if (doc.exists) {
      this.id = doc.documentID;
      this.name = doc.data["name"];
    }
  }
  toJson() {
    return {
      "name": name,
    };
  }
  @override
    String toString() {
      // TODO: implement toString
      return "name :$name id:$id";
    }
}
