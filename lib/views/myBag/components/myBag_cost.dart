import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MyBagCost extends StatefulWidget {
  @override
  _MyBagCost createState() => _MyBagCost();
  final String code;

  const MyBagCost({
    Key key,
    this.code,
  }) : super(key: key);
}

class _MyBagCost extends State<MyBagCost> {
  double _totalCost = 0;
  String _userId;
  void readData() {
    DatabaseReference bagRef = FirebaseDatabase.instance
        .reference()
        .child("bag")
        .child(_userId)
        .child('Bag_Item');
    bagRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      _totalCost = 0;
      for (var key in KEYS) {
        int q = DATA[key]['Quantity'];
        double c = DATA[key]['Total_Cost'];
        _totalCost = _totalCost + cost(q, c);
      }

      DatabaseReference customersRef =
          FirebaseDatabase.instance.reference().child("bag");
      customersRef.child(_userId).update({'Total_Cost': _totalCost});

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    readData();
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Text.rich(
      TextSpan(
        text: "Sub Total:\n",
        children: [
          TextSpan(
            text: "${_totalCost.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  double cost(int quantity, double cost) {
    return quantity * cost;
  }
}
