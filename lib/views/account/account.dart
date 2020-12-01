import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:instaStore/models/Checkout.dart';
import '../../models/Customer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './editAccount.dart';

class AccountScreen extends StatefulWidget {
  static String routeName = "/accountScreen";
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreen createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  String _uid;
  FirebaseAuth _auth;
  Customer _costumer;
  String _email;
  static List<Customer> customersList = [];
  static List<CheckOut> checkOutList = [];

  void readData2() {
    DatabaseReference checkoutRef =
        FirebaseDatabase.instance.reference().child("checkout");
    checkoutRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      checkOutList.clear();
      for (var key in KEYS) {
        if (DATA[key]['Costumer_Id'] == _uid) {
          CheckOut checkOut = new CheckOut(
              cosId: DATA[key]['Costumer_Id'],
              date: DATA[key]['Data'],
              grandCost: DATA[key]['Total_cost'],
              status: DATA[key]['Status'],
              id: key);
          checkOutList.add(checkOut);
        }
      }

      setState(() {});
    });
  }

  void readData() {
    _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;
    _email = user.email;
    _uid = user.uid;
    DatabaseReference customersRef =
        FirebaseDatabase.instance.reference().child("customer");
    customersRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      customersList.clear();
      for (var key in KEYS) {
        Customer costumer = new Customer(
            phone: DATA[key]['Phone'], name: DATA[key]['Name'], id: key);
        customersList.add(costumer);
      }

      _auth = FirebaseAuth.instance;
      final User user = _auth.currentUser;
      _email = user.email;
      _uid = user.uid;
      for (Customer c in customersList) {
        if (c.id == user.uid) {
          _costumer = Customer(id: user.uid, name: c.name, phone: c.phone);
        }
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    readData2();
  }

  @override
  Widget build(BuildContext context) {
    readData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _costumer == null
        ? Stack()
        : Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.43,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double innerHeight = constraints.maxHeight;
                              double innerWidth = constraints.maxWidth;
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: innerHeight * 0.72,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          )
                                        ],
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 80,
                                          ),
                                          _costumer == null
                                              ? Text("")
                                              : Text(
                                                  _costumer.name,

                                                  ///here
                                                  style: TextStyle(
                                                    color: Colors.pink,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 37,
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                  checkOutList.length == 0
                                                      ? Text(
                                                          '0',
                                                          style: TextStyle(
                                                            color: Colors.pink,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 25,
                                                          ),
                                                        )
                                                      : Text(
                                                          '${checkOutList.length}',
                                                          style: TextStyle(
                                                            color: Colors.pink,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 110,
                                    right: 20,
                                    child: IconButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, EditAccountScreen.routeName,
                                          arguments: {
                                            'name': '${_costumer.name}',
                                            'phone': '${_costumer.phone}',
                                            'email': '$_email',
                                            'uid': '$_uid'
                                          }),
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/profile.png',
                                          width: innerWidth * 0.45,
                                          fit: BoxFit.fitWidth,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: height * 0.5,
                          width: width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              )
                            ],
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'My Orders',
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  (checkOutList.length == 0)
                                      ? Container(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 100,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50))),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "There is no Orders",
                                                          style: TextStyle(
                                                              fontSize: 20.1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: <Widget>[
                                              ...List.generate(
                                                checkOutList.length,
                                                (index) {
                                                  return orderCard(
                                                      checkOutList[index].id,
                                                      checkOutList[index]
                                                          .grandCost,
                                                      checkOutList[index].date,
                                                      checkOutList[index]
                                                          .status);
                                                },
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Container(
                                width: 250,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15,
                                            bottom: 8,
                                            left: 8,
                                            right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.share,
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                shareApp(
                                                    "https://github.com/shahedalkharsa/InstaStore",
                                                    "instaStore Application");
                                              },
                                              child: Text(
                                                "   Share App",
                                                style: TextStyle(
                                                    fontSize: 17.1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }

  Future<void> shareApp(dynamic link, String title) async {
    await FlutterShare.share(
        title: 'Codding Application',
        text: title,
        linkUrl: link,
        chooserTitle: 'Where you want to share ');
  }

  Container orderCard(String id, String grandCost, String date, String status) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Id:",
                                  style: TextStyle(
                                      fontSize: 17.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$id",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date :",
                                  style: TextStyle(
                                      fontSize: 17.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$date",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Cost :",
                                  style: TextStyle(
                                      fontSize: 17.1,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$grandCost SAR",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status :",
                                  style: TextStyle(
                                      fontSize: 17.1,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "$status",
                                  style: TextStyle(
                                      color: Colors.pink,
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
          ],
        ),
      ),
    );
  }
}
