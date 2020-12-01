import 'package:flutter/material.dart';
import 'package:instaStore/models/BagItem.dart';
import 'package:instaStore/models/Product.dart';
import './cartCounter.dart';
import '../../../views/details/details_screen.dart';

class MyBagCard extends StatefulWidget {
  final List<Product> productsList;

  const MyBagCard(
      {Key key, @required this.bagItem, @required this.productsList})
      : super(key: key);

  final BagItem bagItem;

  @override
  _MyBagCardState createState() => _MyBagCardState();
}

class _MyBagCardState extends State<MyBagCard> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    List<Product> productList = widget.productsList
        .where((element) => element.name == widget.bagItem.productName)
        .toList();
    String image = productList[0].image;

    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: productList[0]),
          ),
          child: SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: productList.length == 0
                    ? Container()
                    : Image.network(image),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.bagItem.productName,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text(
              "${widget.bagItem.totalCost} SAR",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 120),
                CartCounter(productName: widget.bagItem.productName)
              ],
            )
          ],
        )
      ],
    );
  }
}
