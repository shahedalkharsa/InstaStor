import 'package:flutter/material.dart';
import '../../../models/WishList.dart';
import '../../../Controllers/palette.dart';
import '../../../models/Product.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../details/details_screen.dart';

class WishlistCard extends StatefulWidget {
  final WishList wishList;
  const WishlistCard({
    Key key,
    @required this.wishList,
  }) : super(key: key);

  static String routeName = "/wishlist";
  @override
  _WishlistCard createState() => new _WishlistCard();
}

class _WishlistCard extends State<WishlistCard> {
  Product _product;

  void readData() {
    DatabaseReference productsRef =
        FirebaseDatabase.instance.reference().child("product");
    productsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      for (var key in KEYS) {
        if (widget.wishList.productName == DATA[key]['Pro_Name']) {
          _product = new Product(
              categoryName: DATA[key]['Cat_Name'],
              description: DATA[key]['Pro_Descr'],
              id: key,
              image: DATA[key]['Pro_Image'],
              isSuggested: DATA[key]['Is_Suggested'],
              name: DATA[key]['Pro_Name'],
              price: DATA[key]['Pro_Price'],
              storeName: DATA[key]['Store_Name']);
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

  Widget build(BuildContext context) {
    return _product == null
        ? Text("")
        : GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments(product: _product),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 88,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(_product.image),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _product.name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "\$${_product.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Palette.darkAmber),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
