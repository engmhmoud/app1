import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/dashboard.dart';
import 'package:flutter/material.dart';

class AddNewUser extends StatefulWidget {
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isAdmin = false;

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[Text("new Friend"), Icon(Icons.face)],
        ),
      ),
      body: Card(
        elevation: 0,
        margin: EdgeInsets.all(30),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("first name"),
                  Card(
                    color: Colors.blueGrey[100],
                    child: Container(
                      child: TextField(
                        controller: _firstNameController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("last name"),
                  Card(
                    color: Colors.blueGrey[100],
                    child: Container(
                      child: TextField(
                        controller: _lastNameController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("username"),
                  Card(color: Colors.blueGrey[100],
                                      child: Container(
                      child: TextField(
                        controller: _usernameController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("password"),
                  Card(color: Colors.blueGrey[100],
                                      child: Container(
                      child: TextField(
                        controller: _passwordController, obscureText: true,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Email"),
                  Card(color: Colors.blueGrey[100],
                                      child: Container(
                      child: TextField(
                        controller: _emailController,
                      ),
                      width: 125,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("is admin"),
                  Container(
                    child: Checkbox(
                      value: _isAdmin,
                      onChanged: (a) {
                        if (mounted)
                          setState(() {
                            _isAdmin = a;
                          });
                      },
                    ),
                    width: 125,
                  )
                ],
              ),
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  checkValues();
                  //UserDAO().saveUser();
                })
          ],
        ),
      ),
    );
  }

  bool hasValue(String val) {
    return (!(val == null || val.trim() == ""));
  }

  bool checkValues() {
    if (!Support.checkValues((_firstNameController.text)))
      showDialog(
        child: AlertDialog(
          title: Text("Enter firstname"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else if (!Support.checkValues(_lastNameController.text))
      showDialog(
        child: AlertDialog(
          title: Text("Enter lastname"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else if (!Support.checkValues(_usernameController.text))
      showDialog(
        child: AlertDialog(
          title: Text("Enter username"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else if (!Support.checkValues(_passwordController.text))
      showDialog(
        child: AlertDialog(
          title: Text("Enter password"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else if (!Support.checkValues(_emailController.text))
      showDialog(
        child: AlertDialog(
          title: Text("Enter Email"),
          actions: <Widget>[Icon(Icons.error)],
        ),
        context: context,
      );
    else {
      UserDAO()
          .saveUser(
              user: User(
                  admin: _isAdmin,
                  amount: 0,
                  firstName: _firstNameController.text,
                  username: _usernameController.text,
                  lastName: _lastNameController.text,
                  pass: _passwordController.text))
          .then((onValue) {
        showDialog(
          child: AlertDialog(
              title: Text(
            "User Added",
          )),
          context: context,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
      });
    }
  }
}
