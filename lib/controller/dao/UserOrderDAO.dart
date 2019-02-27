import 'package:app1/model/UserOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../support.dart';

class UserOrderDAO {
  Future<QuerySnapshot> getAllUserOrders() {
    return support.TabelUserOrder.getDocuments();
  }

  DocumentReference getUserOrder({String id}) {
    return support.TabelUserOrder.document(id);
  }

  Future<QuerySnapshot> getUserOrderBy({String field, String value}) {
    return support.TabelUserOrder.where(field, isEqualTo: value).getDocuments();
  }

  void saveOrderToUser({UserOrder order}) {
    support.TabelUserOrder.document().setData(order.toJson());
  }
}
