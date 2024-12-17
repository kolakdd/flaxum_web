import 'package:flutter/material.dart';
import '../../models/object_.dart';
import '../../utils/get_position.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObjectGraphStateful extends StatefulWidget {
  const ObjectGraphStateful(
      {super.key, required Object_ object, required int index})
      : _object = object,
        _index = index;
  final Object_ _object;
  final int _index;

  @override
  State<ObjectGraphStateful> createState() => _ObjectGraphStateful();
}

Widget graphElement(type, double size) {
  return Builder(builder: (context) {
    if (type == "Dir") {
      return IconButton(
          icon: SvgPicture.asset('assets/folder.svg',
              width: size, height: size, semanticsLabel: 'Folder'),
          onPressed: () {});
    } else {
      return IconButton(
          icon: SvgPicture.asset('assets/file.svg',
              width: size, height: size, semanticsLabel: 'File'),
          onPressed: () {});
    }
  });
}

Widget graphElementTextRiched(element, name) {
  return SizedBox(
    width: 190,
    height: 190,
    child: Column(
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 24,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold),
        ),
        element,
      ],
    ),
  );
}

class _ObjectGraphStateful extends State<ObjectGraphStateful> {
  @override
  Widget build(BuildContext context) {
    final element = graphElement(widget._object.type, 140);
    Offset position = generatePoint(140, widget._index);
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
            feedback: graphElementTextRiched(element, widget._object.name),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: graphElementTextRiched(element, widget._object.name),
            ),
            onDragEnd: (details) => setState(() {
                  double dx =
                      details.offset.dx - MediaQuery.of(context).size.width / 3;
                  double dy = details.offset.dy -
                      MediaQuery.of(context).size.height / 15;
                  position = Offset(dx, dy);
                }),
            child: graphElementTextRiched(element, widget._object.name)));
  }
}
