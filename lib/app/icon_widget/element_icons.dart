import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flaxum_fileshare/app/models/object_/object_.dart';

const String assetsFolderSvg = 'assets/folder.svg';
const String assetsFileSvg = 'assets/file.svg';

// Иконка объекта, файла или папки
Widget objectIcon(type, double size, Object_ item) {
  return Builder(builder: (context) {
    if (type == "Dir") {
      return dirIcon(context, item, size);
    }
    return fileIcon(size);
  });
}

// иконка директории
Widget dirIcon(BuildContext context, Object_ item, double size) {
  return SvgPicture.asset(assetsFolderSvg,
      width: size, height: size, semanticsLabel: 'Folder');
}

// иконка файла
Widget fileIcon(double size) {
  return SvgPicture.asset(assetsFileSvg,
      width: size, height: size, semanticsLabel: 'File');
}
