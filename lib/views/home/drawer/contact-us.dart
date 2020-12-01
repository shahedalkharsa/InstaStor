import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static String routeName = "/contactUs";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, ContactUsScreen.routeName);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.pink,
        elevation: 6,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
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
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Email:             support@instaStore.com",
                        style: TextStyle(
                            fontSize: 17.1, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Phone:           +966547086230              ",
                        style: TextStyle(
                            fontSize: 17.1, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/logo.png'),
          ],
        ),
      ),
    );
  }
}
