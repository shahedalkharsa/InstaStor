import 'package:flutter/material.dart';

class BagItem {
  final int quantity;
  final double totalCost;
  final String productName;

  BagItem({
    @required this.productName,
    @required this.quantity,
    @required this.totalCost,
  });
}
