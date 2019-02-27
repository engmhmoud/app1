import 'package:app1/controller/dao/UserDAO.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Dashboard.dart';
import 'package:flutter/material.dart';

class RemoveUser extends StatefulWidget {
  final List<User> data;
  RemoveUser(this.data, {Key key}) : super(key: key);

  _RemoveUserState createState() => _RemoveUserState(data);
}

class _RemoveUserState extends State<RemoveUser> {
  final List<User> data;
  List<bool> checkData;
  int length;
  _RemoveUserState(this.data) {
    length = data.length;
    checkData = List(length);
    int i = 0;
    data.forEach((a) {
      checkData[i++] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Remove USer"),
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
                  "Remove",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  List<User> selected = List();
                  int selectedCount = 0;
                  int counter = 0;
                  print(data.length);
                  print(checkData.length);
                  data.forEach((user) {
                    if (checkData[counter]) {
                      selectedCount++;
                      selected.add(data[counter]);
                    }
                    counter++;
                  });
                  if (selectedCount < 1)
                    showDialog(
                      child: AlertDialog(
                        title: Text(
                          "You Must Select at least 1",
                        ),
                        actions: <Widget>[Icon(Icons.error)],
                      ),
                      context: context,
                    );
                  else {
                    selected.forEach((selected) {
                      UserDAO().remove(selected.id);
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (C) => DashboardMainPage()));
                  }
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
        title: Text(data[index].username),
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
                data[index].firstName.substring(0, 1).toUpperCase() +
                data[index].lastName.substring(0, 1).toUpperCase(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        subtitle: Text(data[index].firstName + " " + data[index].lastName),
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
