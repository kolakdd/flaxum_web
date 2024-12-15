import 'package:flutter/material.dart';
import '../../models/geometry.dart';
import '../../models/object_.dart';
import '../../utils/get_position.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObjectGraphStateful extends StatefulWidget {
  const ObjectGraphStateful({super.key, required Object_ object, required int index}) : _object = object, _index = index;
  final Object_ _object;
  final int _index;


  @override
  State<ObjectGraphStateful> createState() => _ObjectGraphStateful();
}

class _ObjectGraphStateful extends State<ObjectGraphStateful> {
  @override
  Widget build(BuildContext context) {
    Offset position = generatePoint(70, widget._index);
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
            feedback: Text(widget._object.name),
            childWhenDragging: Opacity(
              opacity: .3,
              child: Text(widget._object.name),
            ),
            onDragEnd: (details) => setState(() {
                  double dx =
                      details.offset.dx - MediaQuery.of(context).size.width / 3;
                  double dy = details.offset.dy -
                      MediaQuery.of(context).size.height / 15;
                  position = Offset(dx, dy);
                }),
            child: Column(
              children: [
                Text(widget._object.name),
                Builder(builder: (context) {
                  if (widget._object.type == "Dir") {
                    return IconButton(
                        icon: SvgPicture.asset('assets/folder.svg',
                            width: 70, height: 70, semanticsLabel: 'Folder'),
                        onPressed: () {});
                  } else {
                    return IconButton(
                        icon: SvgPicture.asset('assets/file.svg',
                            width: 70, height: 70, semanticsLabel: 'File'),
                        onPressed: () {});
                  }
                })
              ],
            )));
  }
}
