import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'dart:async';

class Transfare {
  static Future<void> transfare(String from, String to, num amount) async {
    print("in Trasfare");
    UserDAO dao = UserDAO();
    dao.getUser(id: from).then((onValue) {
      User fromUser = User.fromDocument(onValue);
      print(fromUser);
      fromUser.amount += amount;
      dao.update(user: fromUser);
    }).then((_) {
      dao.getUser(id: to).then((onValue) {
        User toUser = User.fromDocument(onValue);
        toUser.amount -= amount;
        dao.update(user: toUser);
      });
    });
  }
}
