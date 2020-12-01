import 'package:flutter/material.dart';
import '../../models/Product.dart';
import '../Products/productCard.dart';
import '../details/details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  static String routeName = "/category";
  @override
  _CategoryScreen createState() => new _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final List<Product> productsList = arguments['productsList'];
    final String uid = arguments['uid'];

    List<Product> _filterdemoProducts =
        productsList.where((f) => f.categoryName == arguments['name']).toList();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            arguments['name'],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    itemCount: _filterdemoProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 22,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        childAspectRatio: 0.75),
                    itemBuilder: (context, index) => ProductCard(
                          uid: uid,
                          press: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(
                                uid: uid,
                                product: _filterdemoProducts[index],
                              ),
                            );
                          },
                          product: _filterdemoProducts[index],
                        ))),
          )
        ],
      ),
    );
  }
}
