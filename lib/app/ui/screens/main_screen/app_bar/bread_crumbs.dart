import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flaxum_fileshare/app/models/system_position.dart';

Widget breadCrumbs(BuildContext context) {
  PositionProvider currentPositionListened =
      Provider.of<PositionProvider>(context, listen: true);
  PositionProvider currentPosition = Provider.of<PositionProvider>(context, listen: false);
  ObjectProvider objProvider = Provider.of<ObjectProvider>(context, listen: false);

  return Row(
    children: [
      Text(
        currentPositionListened.data.currentScope == null ? "No scope" : currentPositionListened.data.currentScope!.toDisplayString() ,
      ),
      const SizedBox(width: 20),
      if (currentPositionListened.data.idStack.isNotEmpty)
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            child: const Text(
              'назад',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onPressed: () async {
              
              currentPosition.removeLastBread();
              currentPosition.clerPagination();
              objProvider.dropData();

              switch (currentPosition.data.currentScope) {
                case Scope.own:
                    await getOwnObjects(context, currentPosition.data.idStack.lastOrNull);
                case Scope.shared:
                    await getSharedObjects(context, currentPosition.data.idStack.lastOrNull);
                case _:
                  break;
              }
            }),
      const SizedBox(width: 12),
      Text(
        currentPositionListened.data.nameStack.join("/"),
      ),
    ],
  );
}


