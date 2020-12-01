import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../../models/Product.dart';
import './components/top_rounded_container.dart';
import './components/product_images.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import './components/heart.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  const DetailsScreen({
    Key key,
  }) : super(key: key);

  @override
  _DetailsScreen createState() => new _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  String _userId;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
          centerTitle: true,
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
      body: Column(
        children: [
          ProductImages(product: agrs.product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        agrs.product.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        agrs.product.storeName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.pink),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      endIndent: 20,
                      indent: 20,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 17,
                          ),
                          child: Text(
                            "${agrs.product.price} SAR",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 185),
                        Heart(
                          productName: agrs.product.name,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 64,
                      ),
                      child: Text(
                        agrs.product.description,
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DefaultButton(
                      text: 'Add to my bag',
                      press: () {
                        const url =
                            'https://instastore-e876a.firebaseio.com/bag/';
                        http.patch(url + _userId + '/Bag_Item.json',
                            body: json.encode({
                              agrs.product.name: {
                                'Quantity': 1,
                                'Total_Cost': agrs.product.price
                              }
                            }));
                        print("added");
                        final snackBar = SnackBar(
                            content: Text('The product is added'),
                            backgroundColor: Colors.pink);
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final String uid;
  ProductDetailsArguments({
    this.uid,
    @required this.product,
  });
}
