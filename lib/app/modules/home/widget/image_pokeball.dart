import 'package:flutter/material.dart';
import 'package:project/app/consts/const_app.dart';

class ImagePokeball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: MediaQuery.of(context).padding.top - 240 / 3,
      left: screenWidth - (240 / 1.6),
      child: Opacity(
        child: Image.asset(
          ConstsApp.blackPokeball,
          height: 240,
          width: 240,
        ),
        opacity: 0.1,
      ),
    );
  }
}
