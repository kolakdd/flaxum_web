import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget mainLogoFlaxum(double height, double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        'assets/rust.svg',
        semanticsLabel: 'Rust',
        height: height,
        width: width,
      ),
      SvgPicture.asset(
        'assets/flutter.svg',
        semanticsLabel: 'Flutter',
        height: height,
        width: width,
      ),
    ],
  );
}
