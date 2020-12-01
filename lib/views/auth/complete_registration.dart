import 'package:flutter/material.dart';
import 'package:instaStore/views/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class CompleteRegistration extends StatefulWidget {
  static String routeName = "/completeRegistration";
  const CompleteRegistration({Key key}) : super(key: key);

  @override
  _CompleteRegistration createState() => _CompleteRegistration();
}

class _CompleteRegistration extends State<CompleteRegistration> {
  void initState() {
    super.initState();
  }

  String _username;
  String _phone;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "Welcome To",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Image.asset('assets/images/logo.png'),
              Text(
                "Complete your information:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.centerRight,
                          colors: [Colors.pink[50], Colors.pink[100]]),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLength: 10,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              hintStyle: const TextStyle(fontSize: 18),
                              hintText: "Name",
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
                            onChanged: (value) => _username = value,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Name is Required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            maxLength: 10,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              hintStyle: const TextStyle(fontSize: 18),
                              hintText: "Phone",
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
                            keyboardType: TextInputType.number,
                            onChanged: (value) => _phone = value,
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
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.pink,
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  print("successful");
                                  final User user =
                                      FirebaseAuth.instance.currentUser;
                                  String userId = user.uid;

                                  print("hello");
                                  print(userId);
                                  print(user.email);
                                  const url =
                                      'https://instastore-e876a.firebaseio.com/customer.json';
                                  http.patch(url,
                                      body: json.encode({
                                        userId: {
                                          'Name': _username,
                                          'Phone': _phone
                                        }
                                      }));
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.routeName);
                                } else {
                                  print("UnSuccessfull");
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              textColor: Colors.white,
                              child: Text("Submit"),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
