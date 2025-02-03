import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget mainLogoFlaxum() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        'assets/rust.svg',
        semanticsLabel: 'Rust',
        height: 100,
        width: 70,
      ),
      SvgPicture.asset(
        'assets/flutter.svg',
        semanticsLabel: 'Flutter',
        height: 100,
        width: 70,
      ),
    ],
  );
}
