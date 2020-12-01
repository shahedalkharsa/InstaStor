import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:commons/commons.dart';

class EditAccountScreen extends StatefulWidget {
  static String routeName = "/editAccountScreen";
  @override
  State<StatefulWidget> createState() => _EditAccountScreen();
}

class _EditAccountScreen extends State<EditAccountScreen> {
  String _username;
  String _phone;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    String name = arguments['name'];
    String email = arguments['email'];
    String phone = arguments['phone'];
    String uid = arguments['uid'];
    _username = name;
    _phone = phone;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Account",
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
                      maxLength: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Name",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: _username,
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
                      onChanged: (value) => _username = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
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
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: email,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Phone",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: _phone,
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
                        RegExp reg = new RegExp("^(05)");
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
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black),
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              DatabaseReference customersRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child("customer");
                              customersRef
                                  .child(uid)
                                  .update({'Name': _username, 'Phone': _phone});

                              successDialog(
                                context,
                                "Your Information is Updated",
                                neutralAction: () {
                                  Navigator.pop(context);
                                },
                              );
                            }
                          },
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "SAVE",
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
