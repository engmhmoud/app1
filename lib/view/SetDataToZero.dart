import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';

class RestoreFactory extends StatefulWidget {
  RestoreFactory({Key key}) : super(key: key);

  _RestoreFactoryState createState() => _RestoreFactoryState();
}

class _RestoreFactoryState extends State<RestoreFactory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restore Default Data "),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          Container(height: 100,
            child: Center(
              child: Text("Are You sure You want To Delete All money"),
            ),
          ),
          Container(height: 50,
            child: Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
          Row(
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
                  checkCancel();
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  checkOk();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkCancel() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (C)=>DashboardMainPage()));
  }

  void checkOk() {
    UserDAO().updateAllAmount(amount: 0);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (C)=>DashboardMainPage()));
  }
}
