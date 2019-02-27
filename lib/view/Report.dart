import 'package:app1/controller/dao/OrderDAO.dart';
import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/model/Order.dart';
import 'package:app1/model/Resturant.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<view> data = List();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reprot"),
        ),
        body: Column(
          children: <Widget>[
            AppBar(
              centerTitle: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Resturant",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    "date",
                    style: TextStyle(color: Colors.black38, fontSize: 13),
                  ),
                  Text(
                    "hour",
                    style: TextStyle(color: Colors.black38, fontSize: 13),
                  ),
                ],
              ),
              titleSpacing: 5,
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Container(
                    child: Icon(
                  Icons.monetization_on,
                  size: 50,
                  color: Colors.blueAccent[700],
                )),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (c, i) => item(i),
                itemCount: data.length,
              ),
            ),
          ],
        ));
  }

  Widget item(int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(2),
      child: ListTile(
        title: Text(data[index].resturant ?? "resturant"),
        leading: CircleAvatar(child: Text("${data[index].order.amount ?? ""}")),
        trailing: Text(formatDate(data[index].order.date)),
      ),
    );
  }

  String formatDate(DateTime dat) {
    return "${dat.day}/${dat.month}    ${dat.hour}:${dat.minute}";
  }

  void init() {
    var dao = ResturantDAO();
    OrderDAO().getAllOrders().then((onValue) {
      onValue.documents.forEach((doc) {
        Order order = Order.fromDocument(doc);
        if (mounted)
          setState(() {
            data.add(
                view(order, Resturant(id: order.resturant, name: "loading")));
          });
        if (mounted)
          setState(() {
            dao.getResturant(id: order.resturant).get().then((onValue) {
              Resturant resturant = Resturant.fromDocument(onValue);
              int index = data
                  .indexWhere((view) => view.order.resturant == resturant.id);
              data[index].resturant = resturant;
            });
          });
      });
    });
  }
}

class view {
  Order order;
  Resturant resturant;
  view(this.order, this.resturant);
}
