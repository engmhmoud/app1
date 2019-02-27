import 'package:app1/model/Order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';

class OrderDAO {
  Future<QuerySnapshot> getAllOrders() {
    return support.TabelOrder.limit(250).orderBy("date", descending: true). getDocuments();
  }

  DocumentReference getOrder({String id}) {
    return support.TabelOrder.document(id);
  }

  Future<QuerySnapshot> getOrderBy({String field, String value}) {
    return support.TabelOrder.where(field, isEqualTo: value).getDocuments();
  }

  DocumentReference saveOrder({Order order}) {
    DocumentReference path = support.TabelOrder.document();
    path.setData(order.toJson());
    return path;
  }
}
