import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name, description, storeName, categoryName, image;
  final double price;
  final bool isSuggested;

  Product(
      {@required this.id,
      @required this.isSuggested,
      @required this.name,
      @required this.price,
      @required this.image,
      @required this.description,
      @required this.categoryName,
      @required this.storeName});
}
