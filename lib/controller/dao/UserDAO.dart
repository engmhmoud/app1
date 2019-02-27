import 'package:app1/model/User.dart';
import '../support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDAO {
  Future<QuerySnapshot> getAllUsers() {
    return support.TabelUser.getDocuments();
  }

  Future<DocumentSnapshot> getUser({String id}) {
    return support.TabelUser.document(id).get();
  }

  Future<QuerySnapshot> getUserBy({String field, dynamic value}) {
    return support.TabelUser.where(field, isEqualTo: value).getDocuments();
  }

  Future<void> saveUser({User user}) {
    return support.TabelUser.document().setData(user.toJson());
  }

  void remove(String docID) {
    support.TabelUser.document(docID).delete();
  }

  void update({User user}) {
    support.TabelUser.document(user.id).updateData(user.toJson());
  }

  void addAmount(User user, num plus) {
    support.TabelUser.document(user.id)
        .updateData({"amount": user.amount + plus});
  }
// void a(User user,) {
//      final DocumentReference postRef =  support.TabelUser.document(user.id);
//     Firestore.instance.runTransaction((Transaction tx) async {
//       DocumentSnapshot postSnapshot = await tx.get(postRef);
//       if (postSnapshot.exists) {
//         await tx.update(postRef, <String, dynamic>{
//           'likesCount': postSnapshot.data['likesCount'] + 1
//         });
//       }
//     });
//   }
  void updateAllAmount({int amount}) {
    getAllUsers().then((onValue) {
      onValue.documents.forEach((doc) {
        User user = User.fromDocument(doc);
        user.amount = 0;
        update(user: user);
      });
    });
  }

  void setAdmin(User user) {
    support.TabelUser.document(user.id).updateData({"admin": true});
  }

  Query getUserByUsernameAndPass({String username }) {
    return support.TabelUser.where("username",isEqualTo: username) ;
  }
}
