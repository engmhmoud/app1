import 'package:app1/model/Resturant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';

class ResturantDAO {
  Future<QuerySnapshot> getAllResturants() {
    return support.TabelResturant.limit(100).orderBy("name"). getDocuments();
  }

  DocumentReference getResturant({String id}) {
    return support.TabelResturant.document(id);
  }

  Future<QuerySnapshot> getResturantBy({String field, String value}) {
    return support.TabelResturant.where(field, isEqualTo: value).getDocuments();
  }

  DocumentReference saveResturant({Resturant resturant}) {
    DocumentReference path = support.TabelResturant.document();
    path.setData(resturant.toJson());
    return path;
  }
}
