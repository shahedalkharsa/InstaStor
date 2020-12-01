import 'package:flutter/material.dart';
import '../../../models/BagItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CartCounter extends StatefulWidget {
  final String productName;

  @override
  _CartCounterState createState() => _CartCounterState();

  const CartCounter({Key key, @required this.productName}) : super(key: key);
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  static List<BagItem> _bagList = [];
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

      _bagList.clear();
      for (var key in KEYS) {
        if (key == widget.productName) {
          if (key == widget.productName) {
            numOfItems = DATA[key]['Quantity'];
          }
        }
      }

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
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
              DatabaseReference customersRef =
                  FirebaseDatabase.instance.reference().child("bag");
              customersRef
                  .child(_userId)
                  .child("Bag_Item")
                  .child(widget.productName)
                  .update({'Quantity': numOfItems});
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
                DatabaseReference customersRef =
                    FirebaseDatabase.instance.reference().child("bag");
                customersRef
                    .child(_userId)
                    .child("Bag_Item")
                    .child(widget.productName)
                    .update({'Quantity': numOfItems});
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
