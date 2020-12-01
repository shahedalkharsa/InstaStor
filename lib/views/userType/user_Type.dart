import 'package:flutter/material.dart';
import '../../views/auth/auth.dart';
import '../../views/userType/store-register.dart';

class UserTypeScreen extends StatelessWidget {
  static String routeName = "/userType";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign Up As",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AuthScreen.routeName),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.pink, Colors.pink[200]]),
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: Center(
                      child: Icon(
                    Icons.person,
                    size: 170,
                    color: Colors.white,
                  )),
                ),
              ),
              Text(
                "User",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, StoreRegisterScreen.routeName),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.pink[200], Colors.pink]),
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: Center(
                      child: Icon(
                    Icons.store,
                    size: 170,
                    color: Colors.white,
                  )),
                ),
              ),
              Text(
                "Store",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
