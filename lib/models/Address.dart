import 'package:flutter/material.dart';

class Adress {
  final String city;
  final String country;
  final String streetAdress;
  final String zipCode;
  final String phone;
  final String altPhone;

  Adress({
    @required this.altPhone,
    @required this.city,
    @required this.country,
    @required this.phone,
    @required this.streetAdress,
    @required this.zipCode,
  });
}
