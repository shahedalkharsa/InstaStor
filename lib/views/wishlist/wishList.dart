import 'package:flutter/material.dart';
import 'components/body.dart';

class WishListSceen extends StatelessWidget {
  static String routeName = "/wishList";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Wishlist",
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
      body: Body(),
    );
  }
}
