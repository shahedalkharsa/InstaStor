import 'package:flutter/material.dart';
import 'package:instaStore/views/checkout/checkout.dart';
import '../../models/Product.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_database/firebase_database.dart';
import './../../models/BagItem.dart';
import './components/myBag_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:commons/commons.dart';
import './../../models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/default_button.dart';
import '../../Controllers/constants.dart';
import './components/myBag_cost.dart';

class MyBagScreen extends StatefulWidget {
  static String routeName = "/myBag";
  final List<Product> productsList;
  const MyBagScreen({Key key, this.productsList}) : super(key: key);

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  static List<BagItem> _bagList = [];
  String _userId;
  String _code;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
        BagItem bagItem = new BagItem(
          productName: key,
          quantity: DATA[key]['Quantity'],
          totalCost: DATA[key]['Total_Cost'],
        );
        _bagList.add(bagItem);
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _bagList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(_bagList[index].productName.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                const url1 = 'https://instastore-e876a.firebaseio.com/bag';
                http.delete(url1 +
                    '/' +
                    _userId +
                    "/Bag_Item/" +
                    _bagList[index].productName +
                    '.json');
                setState(() {
                  _bagList.removeAt(index);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: _bagList[index] == null
                  ? Container()
                  : MyBagCard(
                      bagItem: _bagList[index],
                      productsList: widget.productsList),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  SizedBox(width: 135),
                  SizedBox(
                      width: 150,
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 1.0),
                            hintStyle: const TextStyle(fontSize: 15),
                            hintText: "Add coupon here",
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.pink),
                            ),
                            errorStyle: const TextStyle(color: Colors.pink),
                          ),
                          onChanged: (value) => _code = value,
                          validator: (String value) {
                            if (value != 'SALE20' && value.length > 0) {
                              return 'The Coupon is not valid';
                            }
                            return null;
                          },
                        ),
                      )),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bagList.length == 0
                      ? Text.rich(
                          TextSpan(
                            text: "Sub Total:\n",
                            children: [
                              TextSpan(
                                text: "${0.00}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : MyBagCost(code: _code),
                  SizedBox(
                    width: 190,
                    child: DefaultButton(
                      text: "Check Out",
                      press: () {
                        if (_formkey.currentState.validate()) {
                          if (_bagList.length > 0) {
                            _bagList.clear();
                            Navigator.pushNamed(
                                context, CheckoutScreen.routeName,
                                arguments: {'code': _code});
                          } else {
                            errorDialog(
                              context,
                              "You cannot proceed with an empty bag",
                              neutralAction: () {},
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
