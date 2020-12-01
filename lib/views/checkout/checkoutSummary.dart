import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:instaStore/views/home/home.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../models/BagItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:commons/commons.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  static String routeName = "/checkoutsummury";
  @override
  State<StatefulWidget> createState() => _CheckoutSummaryScreen();
}

class _CheckoutSummaryScreen extends State<CheckoutSummaryScreen> {
  String _userId;
  double _totalCost = 0;
  String _name;
  List<BagItem> _bagList = [];

  void readItems() {
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

  void readData() {
    DatabaseReference bagRef =
        FirebaseDatabase.instance.reference().child("bag").child(_userId);
    bagRef.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      _totalCost = DATA['Total_Cost'];
      print(DATA['Total_Cost']);

      setState(() {});
    });

    DatabaseReference costumerRef =
        FirebaseDatabase.instance.reference().child("customer").child(_userId);
    costumerRef.once().then((DataSnapshot snap) {
      var DATA = snap.value;
      _name = DATA['Name'];
      print(DATA['Name']);

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    readData();
    readItems();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    String adress = arguments['Adress'];
    String country = arguments['Country'];
    String code = arguments['code'];
    String city = arguments['City'];
    String phone = arguments['Phone'];
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Checkout Summary",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              color: Colors.white,
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Option :",
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 8, left: 8, right: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_box,
                                  ),
                                  Text(
                                    "   Cach on delivery",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Text(
                "Order Summary :",
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 8, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub Total :",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${_totalCost.toStringAsFixed(2)} SAR",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery :",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "30 SAR",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cash on Delivery :",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "30 SAR",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            code == 'SALE20'
                                ? Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "The discount:",
                                              style: TextStyle(
                                                  fontSize: 17.1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "-${(_totalCost * (0.2)).toStringAsFixed(2)} SAR",
                                              style: TextStyle(
                                                  fontSize: 17.1,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      )
                                    ],
                                  )
                                : Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "The discount:",
                                              style: TextStyle(
                                                  fontSize: 17.1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "- 0 SAR",
                                              style: TextStyle(
                                                  fontSize: 17.1,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Grand Total :",
                                    style: TextStyle(
                                        fontSize: 17.1,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  code == "SALE20"
                                      ? Text(
                                          "${(_totalCost + 30 + 30 - (_totalCost * 0.2)).toStringAsFixed(2)} SAR",
                                          style: TextStyle(
                                              fontSize: 17.1,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "${(_totalCost + 30 + 30).toStringAsFixed(2)} SAR",
                                          style: TextStyle(
                                              fontSize: 17.1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Text(
                "Deliver To :",
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 8, left: 8, right: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Name :",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "  $_name ",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Address :",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "  $adress ",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "City :",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "  $city ",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Country :",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "  $country ",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Phone Number :",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "  $phone ",
                                    style: TextStyle(
                                        fontSize: 15.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                      onPressed: () {
                        final DateTime now = DateTime.now();
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        String formatted = formatter.format(now);
                        const url =
                            'https://instastore-e876a.firebaseio.com/checkout.json';
                        http.post(url,
                            body: json.encode({
                              'Cash_OD': 30,
                              'Costumer_Id': _userId,
                              'Data': "$formatted",
                              'Delivery': 30,
                              'Pay_Option': "Cash on Delivery",
                              'Status': "Pending",
                              'Total_cost': "${_totalCost.toStringAsFixed(2)}"
                            }));

                        const url2 =
                            'https://instastore-e876a.firebaseio.com/pastOrders.json';
                        print(_bagList.length);
                        _bagList.forEach((element) {
                          http.post(url2,
                              body: json.encode({
                                'Data': "$formatted",
                                'Costumer_Id': _userId,
                                'Bag_Item': {
                                  element.productName: {
                                    'Total_cost': element.totalCost,
                                    'Quantity': element.quantity
                                  }
                                }
                              }));
                        });

                        successDialog(
                          context,
                          "Congratulations, your order has successully added",
                          neutralAction: () {
                            const url1 =
                                'https://instastore-e876a.firebaseio.com/bag';
                            http.delete(url1 + '/' + _userId + '.json');
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          },
                        );
                      },
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "CONIRM ORDER",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.amber)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
