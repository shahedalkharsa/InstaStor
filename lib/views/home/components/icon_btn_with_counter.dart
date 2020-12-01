import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IconBtnWithCounter extends StatefulWidget {
  const IconBtnWithCounter(
      {Key key, @required this.iconData, @required this.press, this.color})
      : super(key: key);

  final IconData iconData;
  final GestureTapCallback press;
  final Color color;

  @override
  _IconBtnWithCounterState createState() => _IconBtnWithCounterState();
}

class _IconBtnWithCounterState extends State<IconBtnWithCounter> {
  String _userId;
  List<String> _favorite = [];

  readData() {
    DatabaseReference wishlistRef =
        FirebaseDatabase.instance.reference().child("wishlist");
    wishlistRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      _favorite.clear();
      for (var key in KEYS) {
        if (DATA[key]['Customer_Id'] == _userId) {
          _favorite.add(DATA[key]['Pro_Name']);
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
      onTap: widget.press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            height: 46,
            width: 50,
            child: Icon(
              widget.iconData,
              color: widget.color,
            ),
          ),
          if (_favorite.length != 0)
            Positioned(
              top: 5,
              right: 4,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white)),
                child: Center(
                  child: Text(
                    "${_favorite.length}",
                    style: TextStyle(
                        fontSize: 10,
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
