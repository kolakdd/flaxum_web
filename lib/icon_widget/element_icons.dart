import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flaxum_fileshare/models/object_/object_.dart';
import 'package:flaxum_fileshare/models/system_position.dart';

import 'package:flaxum_fileshare/network/objects/fetch_objects.dart';
import 'package:flaxum_fileshare/providers/position_provider.dart';

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

// иконка директории и её действия
Widget dirIcon(BuildContext context, Object_ item, double size) {
  return IconButton(
      icon: SvgPicture.asset(assetsFolderSvg,
          width: size, height: size, semanticsLabel: 'Folder'),
      onPressed: () async {
        //todo : вынести action
        switch (Provider.of<PositionProvider>(context, listen: false)
            .data
            .currentScope!) {
          case Scope.own:
            getOwnObjects(context, item.id);
            Provider.of<PositionProvider>(context, listen: false)
                .pushBread(item);
            break;
          case Scope.trash:
            break;
          case Scope.shared:
            getSharedObjects(context, item.id);
            Provider.of<PositionProvider>(context, listen: false)
                .pushBread(item);
            break;
        }
      });
}

// иконка файла и её действия
Widget fileIcon(double size) {
  return IconButton(
      icon: SvgPicture.asset(assetsFileSvg,
          width: size, height: size, semanticsLabel: 'File'),
      onPressed: () {});
}
