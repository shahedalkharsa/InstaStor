import 'package:flutter/material.dart';
import '../../../views/details/details_screen.dart';
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import 'section_title.dart';

class Suggestions extends StatelessWidget {
  final List<Product> productsList;
  const Suggestions({Key key, this.productsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Product> _filterdemoProducts =
        productsList.where((f) => f.isSuggested == true).toList();
    return _filterdemoProducts.length == 0
        ? Container()
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(title: "Suggestions"),
              ),
              SizedBox(height: 20),
              _filterdemoProducts.length == 0
                  ? Container()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            _filterdemoProducts.length,
                            (index) {
                              return _filterdemoProducts[index] == null
                                  ? Container()
                                  : ProductCard(
                                      product: _filterdemoProducts[index],
                                      press: () => Navigator.pushNamed(
                                          context, DetailsScreen.routeName,
                                          arguments: ProductDetailsArguments(
                                              product:
                                                  _filterdemoProducts[index])),
                                    );
                              return SizedBox
                                  .shrink(); // here by default width and height is 0
                            },
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    )
            ],
          );
  }
}
