import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/WishList.dart';
import 'wishlist_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<WishList> _wishList = [];
  String _userId;

  readData() {
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    DatabaseReference wishlistRef =
        FirebaseDatabase.instance.reference().child("wishlist");
    wishlistRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      for (var key in KEYS) {
        if (DATA[key]['Customer_Id'] == _userId) {
          WishList item = new WishList(
              customerId: DATA[key]['Customer_Id'],
              productName: DATA[key]['Pro_Name'],
              wishListId: key);
          print(DATA[key]['Pro_Name']);
          _wishList.add(item);
        }
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return _wishList.length == 0
        ? Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Your wishlist is empty",
                            style: TextStyle(
                                fontSize: 22.1,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Save your favourite items so you don't loss sight of them ",
                            textAlign: TextAlign.center,
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
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: _wishList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(_wishList[index].wishListId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    const url1 =
                        'https://instastore-e876a.firebaseio.com/wishlist';
                    http.delete(
                        url1 + '/' + _wishList[index].wishListId + '.json');
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: WishlistCard(wishList: _wishList[index]),
                ),
              ),
            ),
          );
  }
}
