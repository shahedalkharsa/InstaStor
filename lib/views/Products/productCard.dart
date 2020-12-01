import 'package:flutter/material.dart';
import '../../models/WishList.dart';
import '../../models/Product.dart';

import './../../components/heart.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final Function press;
  final List<WishList> wishlist;
  final String uid;
  const ProductCard(
      {Key key, this.product, this.press, this.wishlist, this.uid})
      : super(key: key);
  @override
  _ProductCard createState() => new _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                  tag: "${widget.product.id}",
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16 / 4),
            child: Text(
              widget.product.name,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.product.price} SAR",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
              ),
              Heart(productName: widget.product.name)
            ],
          )
        ],
      ),
    );
  }
}
