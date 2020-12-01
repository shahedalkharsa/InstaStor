import 'package:flutter/material.dart';
import '../../models/Store.dart';
import '../Products/products.dart';
import '../../models/Product.dart';
import 'package:firebase_database/firebase_database.dart';

class StoresScreen extends StatefulWidget {
  static String routeName = "/stores";
  final List<Product> productsList;
  const StoresScreen({Key key, this.productsList}) : super(key: key);
  @override
  _StoresScreen createState() => _StoresScreen();
}

class _StoresScreen extends State<StoresScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Store> storesList = [];

  void initState() {
    super.initState();

    DatabaseReference storesRef =
        FirebaseDatabase.instance.reference().child("store");
    storesRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      storesList.clear();
      for (var key in KEYS) {
        Store store =
            new Store(storeImage: DATA[key]['Store_Image'], storeName: key);
        storesList.add(store);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext cnt) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: storesList.length,
              itemBuilder: (context, index) {
                return stoList(storesList[index].storeImage,
                    storesList[index].storeName, cnt);
              },
            )),
      ),
    );
  }

  Container stoList(String img, String name, context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          openProductsPage(context, name);
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60))),
              ),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Hero(
                      tag: '$img',
                      child: Container(
                        margin: EdgeInsets.only(left: 55),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )),
                  VerticalDivider(
                    width: 110,
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openProductsPage(context, String name) {
  Navigator.pushNamed(context, ProductsScreen.routeName, arguments: {
    'name': '$name',
    'productsList': context.widget.productsList
  });
}
