import 'package:flaxum_fileshare/app/models/flaxum_object/flaxum_object.dart';
import 'package:flaxum_fileshare/app/models/system_position.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/object_list/object_list.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/user_list/user_list.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/left_side_bar/left_side_bar.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/right_side_details/right_side_details.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget generalListBuider(
    PositionProvider posProvider, Future<List<FlaxumObject>> futureObjectList) {
  return posProvider.data.currentScope == Scope.users
      ? usersListBuilder()
      : objectListBuilder(futureObjectList);
}

Widget objectListBuilder(Future<List<FlaxumObject>> futureObjectList) {
  return FutureBuilder<List<FlaxumObject>>(
    future: futureObjectList,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color.fromARGB(255, 165, 165, 165),
            size: 200,
          ),
        );
      } else {
        return const Row(
          children: [
            LeftSidebar(),
            Expanded(child: ObjectList()),
            RightSideDetails(),
          ],
        );
      }
    },
  );
}

Widget usersListBuilder() {
  return const Row(
    children: [
      LeftSidebar(),
      Expanded(child: UserList()),
      RightSideDetails(),
    ],
  );
}
