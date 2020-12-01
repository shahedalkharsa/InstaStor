import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static String routeName = "/aboutAs";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, AboutUsScreen.routeName);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.pink,
        elevation: 6,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[100]],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/logo.png'),
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
                  child: Text(
                    "InstaStore is a mobile application defined as a self-sufficient system that enables customers to browse through the shops, and a system administrator to approve and reject requests for new shops and maintain lists of shop categories and customer information. InstaStore is aimed towards the customer who wants to buy in an arranged way and the business owners who want to reach out to the maximum cross-section of customers. It is bridging the gap between the seller and the customer.",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 17.1, fontWeight: FontWeight.bold),
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
