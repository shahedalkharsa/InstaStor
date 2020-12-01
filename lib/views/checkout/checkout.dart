import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaStore/views/checkout/checkoutSummary.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";
  @override
  State<StatefulWidget> createState() => _CheckoutScreen();
}

class _CheckoutScreen extends State<CheckoutScreen> {
  String _address;
  String _zipCode;
  String _phone;
  String _altPhone;
  String _userId;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    String code = arguments['code'];
    String city = "Saudi Arabia";
    String country = "Riyadh";
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Address",
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formkey,
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 40,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Address",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
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
                      onChanged: (value) => _address = value,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Adress is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.black),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "City",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: city,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.black),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Country",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: country,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Zip Code",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _zipCode = value,
                      maxLength: 5,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Zip Code is Required';
                        } else if (value.length != 5) {
                          return 'Zip Code should be 5 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Phone",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _phone = value,
                      maxLength: 10,
                      validator: (String value) {
                        RegExp reg = new RegExp("^[05]");
                        if (value.isEmpty) {
                          return 'Phone is Required';
                        } else if (value.length != 10) {
                          return 'Phone should be 10 digits';
                        } else if (!reg.hasMatch(value)) {
                          return 'Phone should start with 05';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Alt Phone",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _altPhone = value,
                      maxLength: 10,
                      validator: (String value) {
                        RegExp reg = new RegExp("^[05]");
                        if (value.length != 0) {
                          if (value.length != 10) {
                            return 'Phone should be 10 digits';
                          } else if (!reg.hasMatch(value) &&
                              value.length == 10) {
                            return 'Phone should start with 05';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              const url =
                                  'https://instastore-e876a.firebaseio.com/address.json';
                              http.patch(url,
                                  body: json.encode({
                                    _userId: {
                                      'Address': _address,
                                      'Phone': _phone,
                                      'Alt_Phone': _altPhone,
                                      'City': city,
                                      'Country': country,
                                      'Zip_code': _zipCode
                                    }
                                  }));
                              print('your addd is added');
                              Navigator.pushNamed(
                                  context, CheckoutSummaryScreen.routeName,
                                  arguments: {
                                    'Adress': _address,
                                    'City': city,
                                    'Country': country,
                                    'Phone': _phone,
                                    'code': code
                                  });
                            }
                          },
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "SAVE ADDRESS",
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
        ),
      ),
    );
  }
}
