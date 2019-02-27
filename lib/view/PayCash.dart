import 'package:app1/controller/logic/Transfare.dart';
import 'package:app1/model/User.dart';
import 'package:app1/view/Support.dart';
import 'package:app1/view/dashboard.dart';
import 'package:flutter/material.dart';

class PayCash extends StatefulWidget {
  PayCash(this.data);
  final List<User> data;
  _PayCashState createState() => _PayCashState(data);
}

class _PayCashState extends State<PayCash> {
  TextEditingController _amountController = TextEditingController();
  final List<User> data;
  List<String> names = List<String>();
  String selectedFrom = null;
  String selectedTO = null;

  void initState() {
    super.initState();
  }

  _PayCashState(this.data) {
    data.forEach((item) {
      String val = item.firstName + " " + item.lastName;
      int lenght = val.length;
      int limit = lenght >= 15 ? 15 : lenght;
      String add = val.substring(0, limit);
      names.add(add);
    });
    //selectedTO = names[1];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pay in cash"),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("from"),
                Card(
                  child: Container(
                    width: 211,
                    child: DropdownButton<String>(
                      items: names.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            selectedFrom = val;
                          });
                      },
                      value: selectedFrom,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("amount"),
                Card(
                  color: Colors.blueGrey[100],
                  child: Container(
                    width: 211,
                    child: TextField(
                      controller: _amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("to"),
                Card(
                  child: Container(
                    width: 211,
                    child: DropdownButton<String>(
                      items: names.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (mounted)
                          setState(() {
                            selectedTO = val;
                          });
                      },
                      value: selectedTO,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
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
      ),
    );
  }

  void checkOk() {
    int from = names.indexOf(selectedFrom);
    int to = names.indexOf(selectedTO);

    if (!Support.checkValues(_amountController.text))
      showDialog(
        child: AlertDialog(title: Text("Enter amount please")),
        context: context,
      );
    else if (from == to) {
      showDialog(
        child: AlertDialog(title: Text("Cannot move from one to himself")),
        context: context,
      );
    } else {
      Transfare.transfare(
              data[from].id, data[to].id, int.parse(_amountController.text))
          .then((onValue) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (C) => DashboardMainPage()));
        showDialog(
          child: AlertDialog(
              title: Text(
            "Moved ${_amountController.text} from :${selectedFrom} to :${selectedTO}",
          )),
          context: context,
        );
      });
    }
  }

  void checkCancel() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => DashboardMainPage()));
  }
}
