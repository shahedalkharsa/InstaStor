import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(20.0),
        child: Image.asset(
          'assets/images/discount.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
