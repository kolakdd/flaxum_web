import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';

const String assetsFolderSvg = 'assets/folder.svg';
const String assetsFileSvg = 'assets/file.svg';

// Иконка объекта, файла или папки
Widget objectIcon(type, double size, FlaxumObject item) {
  return Builder(builder: (context) {
    if (type == "Dir") {
      return dirIcon(context, size);
    }
    return fileIcon(size);
  });
}

// иконка директории
Widget dirIcon(BuildContext context, double size) {
  return SvgPicture.asset(assetsFolderSvg,
      width: size, height: size, semanticsLabel: 'Folder');
}

// иконка файла
Widget fileIcon(double size) {
  return SvgPicture.asset(assetsFileSvg,
      width: size, height: size, semanticsLabel: 'File');
}
