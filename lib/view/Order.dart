import 'package:app1/controller/dao/OrderDAO.dart';
import 'package:app1/controller/dao/ResturantDAO.dart';
import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/controller/dao/UserOrderDAO.dart';
import 'package:app1/model/Order.dart';
import 'package:app1/model/Resturant.dart';
import 'package:app1/model/User.dart';
import 'package:app1/model/UserOrder.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final List<User> data;
  final int length;

  const OrderPage(this.data, this.length, {Key key}) : super(key: key);
  _OrderPageState createState() => _OrderPageState(data, length);
}

class _OrderPageState extends State<OrderPage> {
  final List<User> data;
  final int length;
  TextEditingController _orderAmountController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();

  num orderAmount = 0;
  num deliveryCharge = 0;
  num total = 0;
  List<Resturant> resturants = List();
  List<String> resturantnames = List<String>();

  List<TextEditingController> _orderCostController = List();
  List<TextEditingController> _userpaiedController = List();

  String selectedRest = "none";

  _OrderPageState(this.data, this.length) {
    resturantnames.add("none");
    _orderAmountController.text = "0";
    _deliveryController.text = "0";
    data.forEach((user) {
      _orderCostController.add(TextEditingController());
      _userpaiedController.add(TextEditingController());
      print(user);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
        elevation: 0,
      ),
      body: Card(
        child: ListView(
          padding: EdgeInsets.only(bottom: 40),
          children: <Widget>[
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Resturant"),
                  Card(
                    child: Container(
                      width: 211,
                      child: DropdownButton<String>(
                        items: resturantnames.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (mounted)
                            setState(() {
                              selectedRest = val;
                            });
                        },
                        value: selectedRest,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 3.5,
              child: Column(
                children: <Widget>[
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Order Amount"),
                        Card(
                          color: Colors.blueGrey[100],
                          child: Container(
                            width: 150,
                            child: TextField(
                              controller: _orderAmountController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onChanged: (s) {
                                setState(() {
                                  orderAmount = Support.round(num.tryParse(
                                      _orderAmountController.text));
                                  orderAmount =
                                      total = deliveryCharge + (orderAmount);
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery  Charge"),
                        Card(
                          color: Colors.blueGrey[100],
                          child: Container(
                            width: 150,
                            child: TextField(
                              controller: _deliveryController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onChanged: (s) {
                                setState(() {
                                  deliveryCharge = Support.round(
                                      num.tryParse(_deliveryController.text));

                                  total = (deliveryCharge) + orderAmount;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Text(
                      "Total Order : ${Support.formatNum(total)}",
                      style: TextStyle(color: Colors.blueAccent[700]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 20,
                  child: Text("User"),
                ),
                Container(
                  height: 20,
                  decoration: _verticalDivider(),
                  child: Text("Order Cost"),
                ),
                Container(
                  height: 20,
                  decoration: _verticalDivider(),
                  child: Text("Dleivery"),
                ),
                Container(
                  height: 20,
                  decoration: _verticalDivider(),
                  child: Text("Paied"),
                )
              ],
            ),
            Container(
              height: 220,
              child: Card(
                  child: ListView.builder(
                itemBuilder: (C, i) => itamBuilder(i),
                itemCount: length,
              )),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blueAccent[700]),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (C) => DashboardMainPage()));
                    },
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.blueAccent[700]),
                    ),
                    onPressed: () {
                      checkOK();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verticalDivider() => BoxDecoration(
        border: Border(
          left: BorderSide(
              color: Colors.blue, width: 1.5, style: BorderStyle.solid),
        ),
      );

  Widget itamBuilder(int i) {
    String _username = Support.prepareString(data[i].username, 4);
    print(_username.length);
    return Card(
      margin: EdgeInsets.only(top: 5),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(_username),
          Card(
            color: Colors.blueGrey[100],
            child: Container(
              width: 70,
              child: TextField(
                controller: _orderCostController[i],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ),
          Text((Support.formatNum(deliveryCharge / length))),
          Card(
            color: Colors.blueGrey[100],
            child: Container(
              width: 70,
              child: TextField(
                controller: _userpaiedController[i],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkOK() {
    //ensure order cost equal order amount
    //ensure userPaied summation equal total
    List<num> orderCost = List(length);
    num orderCostSum = 0;

    List<num> paied = List(length);
    num paiedSum = 0;
    for (var i = 0; i < length; i++) {
      orderCost[i] = Support.getNum(_orderCostController[i].text);
      print("order per user $i  ${orderCost[i]}");
      orderCostSum += orderCost[i];

      //---
      paied[i] = Support.getNum(_userpaiedController[i].text);
      print("paied $i  ${paied[i]}");
      paiedSum += paied[i];
    }
    if (orderCostSum != orderAmount) {
      print(paiedSum);
      showDialog(
        child: AlertDialog(
            title: Text("order Cost Summation must equal $orderAmount")),
        context: context,
      );
    } else if (paiedSum != total) {
      print(paiedSum);
      showDialog(
        child: AlertDialog(title: Text("total paied not equal $total")),
        context: context,
      );
    } else {
      OrderDAO _orderDao = OrderDAO();
      List<String> users = List();
      data.forEach((f) {
        users.add(f.id);
      });
      DocumentReference orderPath = _orderDao.saveOrder(
          order: Order(
              date: DateTime.now(),
              amount: orderAmount,
              deliveryCharge: deliveryCharge,
              totalOrderCost: total,
              usersOrders: users,
              resturant:
                  resturants[resturantnames.indexOf(selectedRest) - 1].id));
      UserDAO userDAO = UserDAO();
      UserOrderDAO userOrderDao = UserOrderDAO();
      for (var i = 0; i < length; i++) {
        num totalUser = orderCost[i] + deliveryCharge / length;
        num diffPlus = paied[i] - totalUser;
        userOrderDao.saveOrderToUser(
            order: UserOrder(
                Order_id: orderPath.path,
                User_id: data[i].id,
                paied: paied[i],
                deliveryCostPerUser: deliveryCharge / length,
                orderCost: orderCost[i]));
        if (diffPlus != 0) userDAO.addAmount(data[i], diffPlus);
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
    }
  }

  void init() {
    ResturantDAO().getAllResturants().then((onValue) {
      if (mounted)
        setState(() {
          onValue.documents.forEach((doc) {
            Resturant res = Resturant.fromDocument(doc);
            print(res);
            resturants.add(Resturant.fromDocument(doc));
            resturantnames.add(res.name);
          });
        });
    });
  }
}
