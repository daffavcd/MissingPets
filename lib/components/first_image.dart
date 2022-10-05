import 'package:flutter/material.dart';

class FirstImage extends StatelessWidget {
  const FirstImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("assets/img/logo-vertical.png"));
  }
}
