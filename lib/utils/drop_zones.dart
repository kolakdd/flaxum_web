import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:typed_data' show Uint8List, BytesBuilder;
import 'dart:math' show min;
import 'dart:async' show Completer;

import 'package:flutter/material.dart';

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
