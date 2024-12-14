import 'package:flutter/material.dart';
import '../../models/geometry.dart';
import '../../models/object_.dart';
import '../../utils/cicle_calc.dart';

class ObjectGraphStateful extends StatefulWidget {
  const ObjectGraphStateful({super.key, required Object_ object})
      : _object = object;
  final Object_ _object;

  @override
  State<ObjectGraphStateful> createState() => _ObjectGraphStateful();
}

class _ObjectGraphStateful extends State<ObjectGraphStateful> {
  Offset position = pointOnCircle(Circle(450.0, 400.0, 400));

  @override
  Widget build(BuildContext context) {
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
          double dx = details.offset.dx - MediaQuery.of(context).size.width / 4;
          double dy =
              details.offset.dy - MediaQuery.of(context).size.height / 15;
          position = Offset(dx, dy);
        }),
        child: Builder(
          builder: (context) {
            if (widget._object.type == "file") {
              return CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color.fromARGB(255, 219, 118, 118),
                  child: Text(widget._object.name));
            }
            return CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 213, 236, 81),
                child: Text(widget._object.name));
          },
        ),
      ),
    );
  }
}
