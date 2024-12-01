// ignore_for_file: avoid_print

import 'dart:async' show Completer;
import 'dart:math' show min, Random, sin, cos;
import 'dart:typed_data' show Uint8List, BytesBuilder;

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'src/rust/frb_generated.dart';
import 'models/geometry.dart' show Circle;


final dateTimeNow = DateTime.now().toString();

final objects = [
  Object("0", "folder", 0, "dir", dateTimeNow),
  Object("1", "file1.exe", 123, "file", dateTimeNow),
  Object("2", "file2.exe", 456, "file", dateTimeNow),
];

final List<Object> items = objects;


void main() async {
  await RustLib.init();
  return runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class Object {
  final String id;
  final String name;
  final int size;
  final String type;
  final String createdAt;

  Object(this.id, this.name, this.size, this.type, this.createdAt);
}

// MAIN
Offset pointOnCircle(Circle circle) {
  final angle = Random().nextDouble() * 20;
  final k = Random().nextDouble() + 1.5;
  final x = circle.x + circle.r / k * cos(angle);
  final y = circle.y + circle.r / k * sin(angle);
  return Offset(x, y);
}

Widget objectListWidget(BuildContext context) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, idx) {
      var item = items[idx];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.id),
            Text(item.name),
            Text(item.type),
            Text(item.size.toString()),
            Text(item.createdAt),
          ],
        ),
      );
    },
  );
}

class ObjectGraphStateful extends StatefulWidget {
  const ObjectGraphStateful({super.key, required Object object})
      : _object = object;
  final Object _object;

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

class DragAreaStateful extends StatefulWidget {
  const DragAreaStateful({super.key, required Widget child}) : _child = child;
  final Widget _child;

  @override
  State<DragAreaStateful> createState() => _DragAreaState();
}

class _DragAreaState extends State<DragAreaStateful> {
  Offset position = const Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: widget._child,
        childWhenDragging: Opacity(
          opacity: .3,
          child: widget._child,
        ),
        onDragEnd: (details) => setState(() => position = details.offset),
        child: widget._child,
      ),
    );
  }
}

class _MainApp extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flaxum_fileshare',
        home: Scaffold(
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height / 15,
              centerTitle: true,
              title: const Text('flaxum_fileshare'),
              backgroundColor: const Color.fromARGB(248, 199, 104, 167),
            ),
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Expanded(
                    child: Row(
                      children: [
                        // список файлов видимой области
                        Expanded(
                          child: Container(
                              color: const Color.fromARGB(255, 54, 244, 168),
                              child: objectListWidget(context)),
                        ),
                        // визуальное файловое пространство
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: const Color.fromARGB(255, 202, 204, 87),
                            child: Stack(
                              children: [
                                for (var object in objects)
                                  ObjectGraphStateful(object: object),
                              ],
                            ),
                          ),
                        ),
                        // информация о пользователе и мета данные
                        Expanded(
                          child: Container(
                            color: const Color.fromARGB(255, 86, 77, 206),
                            child: const Stack(
                              children: [
                                Center(
                                    child: Text(
                                        "информация о пользователе и мета данные")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                        child: Row(children: [
                      const Spacer(),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 231, 80, 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5);
                                        }
                                        return null; // Use the component's default.
                                      },
                                    ),
                                  ),
                                  child: const Text('Загрузить файл'),
                                  onPressed: () {}),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5);
                                        }
                                        return null; // Use the component's default.
                                      },
                                    ),
                                  ),
                                  child: const Text('Создать папку'),
                                  onPressed: () {}),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                        if (states
                                            .contains(WidgetState.pressed)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5);
                                        }
                                        return null; // Use the component's default.
                                      },
                                    ),
                                  ),
                                  child: const Text('Очистить корзину'),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ]))
                  ])
                ]))));
  }
}

class DropZoneStateful extends StatefulWidget {
  const DropZoneStateful({super.key});

  @override
  State<DropZoneStateful> createState() => _DropZoneStateful();
}

class _DropZoneStateful extends State<DropZoneStateful> {
  late DropzoneViewController controller1;
  String message1 = 'Зона для дропа';
  bool highlighted1 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Облачное хранилище'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: highlighted1
                    ? const Color.fromARGB(255, 54, 244, 168)
                    : Colors.transparent,
                child: Stack(
                  children: [
                    buildZone1(context),
                    Center(child: Text(message1)),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final files = await controller1.pickFiles(multiple: true);
                if (files.length == 1) {
                  print("загрузка файлов");
                  final bytes = await controller1.getFileData(files[0]);
                  print('Read bytes with length ${bytes.length}');
                  print(bytes.sublist(0, min(bytes.length, 20)));
                } else {
                  print("выбрать меньше файлов");
                }
              },
              child: const Text('Pick file'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (error) => print('Zone 1 error: $error'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDropFile: (file) async {
            print('Zone 1 drop: ${file.name}');
            setState(() {
              message1 = '${file.name} dropped';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(file);
            print('Read bytes with length ${bytes.length}');
            print(bytes.sublist(0, min(bytes.length, 20)));
          },
          onDropString: (s) {
            print('Zone 1 drop: $s');
            setState(() {
              message1 = 'text dropped';
              highlighted1 = false;
            });
            print(s.substring(0, min(s.length, 20)));
          },
          onDropInvalid: (mime) => print('Zone 1 invalid MIME: $mime'),
          onDropFiles: (files) => print('Zone 1 drop multiple: $files'),
          onDropStrings: (strings) => print('Zone 1 drop multiple: $strings'),
        ),
      );

  Future<Uint8List> collectBytes(Stream<List<int>> source) {
    var bytes = BytesBuilder(copy: false);
    var completer = Completer<Uint8List>.sync();
    source.listen(
      bytes.add,
      onError: completer.completeError,
      onDone: () => completer.complete(bytes.takeBytes()),
      cancelOnError: true,
    );
    return completer.future;
  }
}
