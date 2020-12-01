import 'package:flutter/material.dart';
import 'section_title.dart';
import '../../../models/Product.dart';
import '../../Products/products.dart';

class Trending extends StatelessWidget {
  final List<Product> productsList;

  const Trending({Key key, this.productsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Trending",
          ),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TrendingCard(
                image: 'https://i.ibb.co/ct4CfY0/Charmaleena.png',
                press: () {
                  openProductsPage(context, "Charmaleena");
                },
              ),
              TrendingCard(
                image: 'https://i.ibb.co/sPQ6mtc/Nobles.png',
                press: () {
                  openProductsPage(context, "Nobles");
                },
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

void openProductsPage(context, String name) {
  Navigator.pushNamed(context, ProductsScreen.routeName, arguments: {
    'name': '$name',
    'productsList': context.widget.productsList
  });
}

class TrendingCard extends StatelessWidget {
  const TrendingCard({
    Key key,
    @required this.image,
    @required this.press,
  }) : super(key: key);

  final String image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
