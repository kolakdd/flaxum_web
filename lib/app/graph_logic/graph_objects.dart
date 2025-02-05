import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/icon_widget/element_icons.dart';
import 'package:flaxum_fileshare/app/models/object_/object_.dart';
import 'package:flaxum_fileshare/app/graph_logic/get_position.dart';

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

class _ObjectGraphStateful extends State<ObjectGraphStateful> {
  @override
  Widget build(BuildContext context) {
    final element = objectIcon(widget._object.type, 140, widget._object);
    Offset position = generatePoint(widget._index);
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
            feedback: graphElementTextRiched(element, widget._object.name),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: graphElementTextRiched(element, widget._object.name),
            ),
            onDragEnd: (details) => {
                  // setState(() {
                  //   double dx =
                  //       details.offset.dx - MediaQuery.of(context).size.width / 3;
                  //   double dy = details.offset.dy -
                  //       MediaQuery.of(context).size.height / 15;
                  //   position = Offset(dx, dy);
                  // }
                  // )
                },
            child: graphElementTextRiched(element, widget._object.name)));
  }
}
