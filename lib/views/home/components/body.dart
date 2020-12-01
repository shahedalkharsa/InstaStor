import 'package:flutter/material.dart';
import './discount_banner.dart';
import 'trending.dart';
import 'suggestions.dart';
import '../../../models/Product.dart';

class Body extends StatefulWidget {
  final List<Product> productsList;
  const Body({Key key, this.productsList}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  void initState() {
    super.initState();
    print("woow");

    print(widget.productsList[0].isSuggested == true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            DiscountBanner(),
            SizedBox(
              height: 25,
            ),
            Trending(productsList: widget.productsList),
            SizedBox(height: 25),
            Suggestions(
              productsList: widget.productsList,
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
