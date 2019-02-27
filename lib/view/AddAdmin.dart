import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';

class AddAdmin extends StatefulWidget {
  final List<User> data;

  const AddAdmin({Key key, this.data}) : super(key: key);
  @override
  _AddAdminState createState() => _AddAdminState(data);
}

class _AddAdminState extends State<AddAdmin> {
  _AddAdminState(this.data) {}
  final List<User> data;
  List<User> nonAdmin;
  List<bool> checkData;
  int length;
  @override
  void initState() {
    nonAdmin = List();
    data.forEach((user) {
      if (!user.admin) nonAdmin.add(user);
    });

    checkData = List();
    length = nonAdmin.length;
    nonAdmin.forEach((admin) {
      checkData.add(false);
    });

    super.initState();
    //init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Admin"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (C, i) => itemBuilder(i),
              itemCount: length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (C) => DashboardMainPage()));
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Add admin",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  print(checkData.length);
                  print(nonAdmin.length);
                  print(length);
                  UserDAO dao = UserDAO();
                  for (var i = 0; i < length; i++) {
                    if (checkData[i]) dao.setAdmin(nonAdmin[i]);
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (C)=>DashboardMainPage()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder(int index) {
    return InkWell(
      child: ListTile(
        isThreeLine: false,
        enabled: true,
        title: Text(nonAdmin[index].username),
        trailing: Wrap(
          children: <Widget>[
            Text("${data[index].amount.toStringAsFixed(2)}"),
            Checkbox(
                value: checkData[index],
                onChanged: (value) {
                  if (mounted)
                    setState(() {
                      checkData[index] = value;
                    });
                })
          ],
        ),
        leading: CircleAvatar(
          maxRadius: 25,
          child: Text(
            "" +
                nonAdmin[index].firstName.substring(0, 1).toUpperCase() +
                nonAdmin[index].lastName.substring(0, 1).toUpperCase(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        subtitle:
            Text(nonAdmin[index].firstName + " " + nonAdmin[index].lastName),
      ),
      onTap: () {
        if (mounted)
          setState(() {
            if (checkData[index])
              checkData[index] = false;
            else
              checkData[index] = true;
          });
      },
    );
  }
}
