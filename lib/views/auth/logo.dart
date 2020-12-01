import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({@required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 55),
      child: Image.asset(
        image,
        width: 200,
        height: 200,
      ),
    );
  }
}
