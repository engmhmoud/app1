import 'package:app1/controller/dao/Local.dart';
import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/dashboard.dart';
import 'package:flutter/material.dart';

User myUser;
Future main() async {
  await Local().getAllUsers().then((onValue) {
    onValue.forEach((val) {
      String username = val['username'];
      String pass = val['password'];
      String id = val['id'];
      print("HER>>>>>>>>>>>>>>>>");
      login(username, pass, id);
    });
    runApp(MyApp(false));
  });
  //runApp(MyApp(false));
}

void login(String username, String pass, String id) {
  print("onlogin");
  UserDAO().getUser(id: id).then((onValue) {
    User s = User.fromDocument(onValue);
    if (s.username == username && s.pass == pass) {
      myUser = s;
      runApp(MyApp(
        true,
      ));
    } else {
      runApp(MyApp(
        false,
      ));
    }
  }, onError: () {
    runApp(MyApp(
      false,
    ));
  });
}

class MyApp extends StatelessWidget {
  final bool login;

  const MyApp(this.login, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(login),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

Widget home(bool login) {
  if (login)
    return DashboardMainPage();
  else
    return MyHomePage();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => DashboardMainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Card(
        margin: EdgeInsets.all(30),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("username"),
                Container(
                    width: 100,
                    child: TextField(
                      controller: _username,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("password"),
                Container(
                    width: 100,
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                    ))
              ],
            ),
            SizedBox(
              height: 40,
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
                      print(myUser);
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
                        if (!Support.checkValues(_username.text)) {
                          showDialog(
                            child: AlertDialog(
                                title: Text("insert Username please")),
                            context: context,
                          );
                        } else if (!Support.checkValues(_password.text)) {
                          showDialog(
                            child: AlertDialog(
                                title: Text("insert password please")),
                            context: context,
                          );
                        } else
                          UserDAO()
                              .getUserByUsernameAndPass(
                                username: _username.text,
                              )
                              .getDocuments()
                              .then((onValue) {
                            if (onValue.documents.length != 0)
                              onValue.documents.forEach((doc) {
                                User s = User.fromDocument(doc);
                                print(s);
                                if (_password.text == s.pass) {
                                  myUser = s;
                                  print(myUser);
                                  Local().saveUser(
                                      id: myUser.id,
                                      pass: myUser.pass,
                                      username: myUser.username);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (C) => DashboardMainPage()));
                                } else {
                                  showDialog(
                                    child: AlertDialog(
                                        title: Text(
                                            "username or password Not valid ")),
                                    context: context,
                                  );
                                }
                              });
                            else {
                              showDialog(
                                child: AlertDialog(
                                    title: Text(
                                        "username or password Not valid ")),
                                context: context,
                              );
                            }
                          });
                      })
                ],
              ),
            )
          ],
        ),
      ),
     
    );
  }
}
