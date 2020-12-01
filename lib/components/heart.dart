import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Heart extends StatefulWidget {
  final String productName;

  @override
  _Heart createState() => _Heart();

  const Heart({
    Key key,
    @required this.productName,
  }) : super(key: key);
}

class _Heart extends State<Heart> {
  bool _isFavorite = false;
  String _userId;
  String _id;

  readData() {
    DatabaseReference wishlistRef =
        FirebaseDatabase.instance.reference().child("wishlist");

    wishlistRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      _isFavorite = false;
      for (var key in KEYS) {
        if (DATA[key]['Customer_Id'] == _userId &&
            DATA[key]['Pro_Name'] == widget.productName) {
          _isFavorite = true;
          _id = key;
        }
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
    readData();
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        const url1 = 'https://instastore-e876a.firebaseio.com/wishlist';
        print(_isFavorite);

        if (_isFavorite) {
          http.delete(url1 + '/' + _id + '.json');
          _isFavorite = !_isFavorite;
        } else if (!_isFavorite) {
          _isFavorite = !_isFavorite;

          const url = 'https://instastore-e876a.firebaseio.com/wishlist.json';
          http.post(url,
              body: json.encode(
                  {'Customer_Id': _userId, 'Pro_Name': widget.productName}));
        }
      },
      child: Container(
        padding: EdgeInsets.all(1),
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: _isFavorite
              ? kPrimaryColor.withOpacity(0.15)
              : kSecondaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.favorite,
          color: _isFavorite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
          size: 15,
        ),
      ),
    );
  }
}
