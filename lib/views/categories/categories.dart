import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:instaStore/models/Category.dart';
import './category.dart';
import '../../models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoriesScreen extends StatefulWidget {
  static String routeName = "/categories";
  final List<Product> productsList;
  const CategoriesScreen({Key key, this.productsList}) : super(key: key);

  @override
  _CategoriesScreen createState() => _CategoriesScreen();
}

class _CategoriesScreen extends State<CategoriesScreen> {
  List<Category> categoriesList = [];
  String _userId;

  void readData() {
    DatabaseReference categoriesRef =
        FirebaseDatabase.instance.reference().child("category");
    categoriesRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      categoriesList.clear();
      for (var key in KEYS) {
        Category category =
            new Category(catimage: DATA[key]['image'], catname: key);
        categoriesList.add(category);
      }

      final User user = FirebaseAuth.instance.currentUser;
      _userId = user.uid;

      setState(() {});
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: categoriesList.length == 0
                  ? Text("")
                  : Column(
                      children: <Widget>[
                        catList(categoriesList[0].catimage,
                            categoriesList[0].catname, context),
                        catList(categoriesList[1].catimage,
                            categoriesList[1].catname, context),
                        catList(categoriesList[2].catimage,
                            categoriesList[2].catname, context),
                        catList(categoriesList[3].catimage,
                            categoriesList[3].catname, context),
                        catList(categoriesList[4].catimage,
                            categoriesList[4].catname, context),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  Container catList(String img, String name, context) {
    int length = name.length;
    double size = length > 15 ? 10 : 17;
    return Container(
      height: 170,
      margin: EdgeInsets.only(bottom: 15),
      child: Row(children: <Widget>[
        RotatedBox(
          quarterTurns: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 10,
                width: 10,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Text("$name",
                    style:
                        TextStyle(fontSize: size, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                height: 170,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(img), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    openCategory(context, name, _userId);
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.symmetric(vertical: 22, horizontal: 35),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40)),
                        color: Colors.amber),
                    child: Center(
                      child: Text(
                        "Products",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

void openCategory(context, String name, String uid) {
  Navigator.pushNamed(context, CategoryScreen.routeName, arguments: {
    'name': '$name',
    'productsList': context.widget.productsList,
    'uid': uid
  });
}
