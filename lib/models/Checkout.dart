import 'package:flutter/material.dart';

class CheckOut {
  final String id;
  final String cosId;
  final String status;
  final String grandCost;
  final String date;

  CheckOut(
      {@required this.date,
      @required this.cosId,
      @required this.status,
      @required this.id,
      @required this.grandCost});
}
