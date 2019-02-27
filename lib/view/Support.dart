import 'dart:math';

class Support {
  static bool checkValues(String val) {
    return (!(val == null || val.trim() == ""));
  }

  static bool checkNum(String val) {
    return (!(val == null || val.trim() == "" || num.tryParse(val) != null));
  }

  static num getNum(String val) {
    num mynum = num.tryParse(val);
    mynum = mynum == null ? 0 : mynum;
    return round(mynum);
  }

  static String prepareString(String val, int length) {
    int valLength = val.length;
    if (valLength == length)
      return val;
    else if (valLength > length)
      return val.substring(0, length);
    else {
      int dif = length - valLength;
      String space = "";
      for (var i = 0; i < dif; i++) {
        space = space + " ";
      }
      return val + space;
    }
  }

  static String formatNum(num val, {int length = 3}) {
    if (val != null)
      return val.toStringAsFixed(length);
    else
      return "0";
  }

  static num round(num val, {int length = 3}) {
    if (val != null)
      return num.parse(val.toStringAsFixed(length));
    else
      return 0;
  }
}
