import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:instaStore/views/wishlist/wishList.dart';
import '../../Views/home/components/body.dart';
import '../../Views/myBag/myBag_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/Product.dart';
import '../../Views/account/account.dart';
import '../../Views/categories/categories.dart';
import '../../Views/stores/stores.dart';
import './drawer/main-drawer.dart';
import './components/icon_btn_with_counter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Product> productsList = [];
  String _userId;
  int _numInFavorite = 0;

  void readData() {
    DatabaseReference productsRef =
        FirebaseDatabase.instance.reference().child("product");
    productsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      productsList.clear();
      for (var key in KEYS) {
        Product product = new Product(
            categoryName: DATA[key]['Cat_Name'],
            isSuggested: DATA[key]['Is_Suggested'],
            description: DATA[key]['Pro_Descr'],
            image: DATA[key]['Pro_Image'],
            name: DATA[key]['Pro_Name'],
            price: DATA[key]['Pro_Price'],
            storeName: DATA[key]['Store_Name'],
            id: key);
        productsList.add(product);
      }

      setState(() {});
    });
    final User user = FirebaseAuth.instance.currentUser;
    _userId = user.uid;
    DatabaseReference fRef =
        FirebaseDatabase.instance.reference().child("wishlist");
    fRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      for (var key in KEYS) {
        if (DATA[key]['Customer_Id'] == _userId) {
          _numInFavorite++;
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

  var _page = 2;
  String _title = "Home";
  final pages = [
    CategoriesScreen(productsList: productsList),
    StoresScreen(productsList: productsList),
    Body(productsList: productsList),
    MyBagScreen(productsList: productsList),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_title, style: TextStyle(fontSize: 30, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: <Widget>[
          IconBtnWithCounter(
            iconData: Icons.favorite,
            press: () {
              Navigator.pushNamed(context, WishListSceen.routeName,
                  arguments: {'list': productsList});
            },
          ),
        ],
      ),
      body: productsList.length == 0 ? Container() : pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.pink,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.black,
          height: 50,
          items: <Widget>[
            Icon(Icons.view_module, size: 20, color: Colors.white),
            Icon(Icons.store, size: 20, color: Colors.white),
            Icon(Icons.home, size: 20, color: Colors.white),
            Icon(Icons.shopping_basket, size: 20, color: Colors.white),
            Icon(Icons.person, size: 20, color: Colors.white)
          ],
          animationDuration: Duration(milliseconds: 200),
          index: 2,
          animationCurve: Curves.bounceInOut,
          onTap: (index) {
            setState(() {
              _page = index;
            });
            onTabTapped(index);
          }),
      drawer: MainDrawer(),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _page = index;
      switch (index) {
        case 0:
          {
            _title = 'Categories';
          }
          break;
        case 1:
          {
            _title = 'Stores';
          }
          break;
        case 2:
          {
            _title = 'Home';
          }
          break;
        case 3:
          {
            _title = 'My Bag';
          }
          break;
        case 4:
          {
            _title = 'My Account';
          }
          break;
      }
    });
  }
}
