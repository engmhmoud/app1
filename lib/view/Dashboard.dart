import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/main.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/AddAdmin.dart';
import 'package:app1/view/AddNewUser.dart';
import 'package:app1/view/AddResturant.dart';
import 'package:app1/view/ChooseToOrder.dart';
import 'package:app1/view/RemoveUser.dart';
import 'package:app1/view/Report.dart';
import 'package:app1/view/SetDataToZero.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'PayCash.dart';

class DashboardMainPage extends StatefulWidget {
  _DashboardMainPageState createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends State<DashboardMainPage> {
  List<User> data = List();
  @override
  void initState() {
    inti();
    super.initState();
  }

  void checkAdmin() {
    showDialog(
      child: AlertDialog(title: Text("You are not admin")),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashbord Main Page",
          style: TextStyle(fontSize: 15),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              child: Icon(
                Icons.settings,
                size: 80,
              ),
              maxRadius: 50,
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.blueAccent[700],
                  ),
                  InkWell(
                    child: Text(
                      "add Friend",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      if (!myUser.admin)
                        checkAdmin();
                      else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (C) => AddNewUser()));
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.red,
                  ),
                  InkWell(
                    child: Text(
                      "Remove Friend",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      if (!myUser.admin)
                        checkAdmin();
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (C) => RemoveUser(data)));
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.blueAccent[700],
                  ),
                  InkWell(
                    child: Text(
                      "Restore Default Data",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      if (!myUser.admin)
                        checkAdmin();
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (C) => RestoreFactory()));
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 40,
                  ),
                  InkWell(
                      child: Text(
                        "Add Admin",
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        if (!myUser.admin)
                          checkAdmin();
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (C) => AddAdmin(
                                        data: data,
                                      )));
                        }
                      }),
                ],
              ),
            ),
            //-----------------
            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.subject,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                  InkWell(
                      child: Text(
                        "Report",
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        if (!myUser.admin)
                          checkAdmin();
                        else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (C) => Report()));
                        }
                      }),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),
            Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.restaurant,
                    size: 40,
                    color: Colors.green,
                  ),
                  InkWell(
                      child: Text(
                        "add Resturant",
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {
                        if (!myUser.admin)
                          checkAdmin();
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (C) => AddResturant()));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          AppBar(
            centerTitle: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Username",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  "amount",
                  style: TextStyle(color: Colors.black38, fontSize: 13),
                ),
              ],
            ),
            titleSpacing: 5,
            leading: Container(),
            backgroundColor: Colors.white,
            elevation: 0,
          ),

          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) => itemBuilder(i),
              itemCount: data.length,
              shrinkWrap: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "new Order",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (C) => ChooseToOrder(data)));
                  }
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "cach to User",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  if (!myUser.admin)
                    checkAdmin();
                  else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => PayCash(data)));
                  }
                  ;
                },
              ),
            ],
          )
          // else
          //   return CircularProgressIndicator();

          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (c, i) => itemBuilder(i),
          //     itemCount: data.length,
          //     shrinkWrap: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget itemBuilder(int index) {
    return ListTile(
      isThreeLine: false,
      enabled: true,
      title: Text(data[index].username),
      trailing: Text("${data[index].amount.toStringAsFixed(2)}"),
      leading: CircleAvatar(
        maxRadius: 25,
        child: Text(
          "" +
              data[index].firstName.substring(0, 1).toUpperCase() +
              data[index].lastName.substring(0, 1).toUpperCase(),
          style: TextStyle(fontSize: 18),
        ),
      ),
      subtitle: Text(data[index].firstName + " " + data[index].lastName),
    );
  }

  void inti() async {
    UserDAO().getAllUsers().then((onValue) {
      onValue.documents.forEach((doc) {
        if (mounted)
          setState(() {
            data.add(User.fromDocument(doc));
          });
      });
    });
  }
}
