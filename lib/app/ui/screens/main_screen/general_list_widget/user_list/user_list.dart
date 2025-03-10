import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flaxum_fileshare/app/network/objects/fetch.dart';
import 'package:flaxum_fileshare/app/network/users/fetch.dart';
import 'package:flaxum_fileshare/app/ui/screens/main_screen/general_list_widget/user_list/user_item/entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flaxum_fileshare/app/models/system_position.dart';

import 'package:flaxum_fileshare/app/providers/object_provider.dart';
import 'package:flaxum_fileshare/app/providers/position_provider.dart';

// Список объектов
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _loadMore() async {
    PositionProvider posProvider =
        Provider.of<PositionProvider>(context, listen: false);

    if (
      posProvider.offset < posProvider.total &&
      _controller.position.maxScrollExtent == _controller.position.pixels
      ) {
      switch (posProvider.data.currentScope) {
        case Scope.own:
          await getOwnObjects(context, null);
        case Scope.shared:
          await getSharedObjects(context, null);
        case Scope.trash:
          await getTrashObjects(context);
        case Scope.systemFiles:
          await getAdminObjecs(context);
        case Scope.users:
          await getUsersList(context);
        case _:
          // todo;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<User> objectList = Provider.of<ObjectProvider>(context).dataUsers;
    MainPosition mainPosition = Provider.of<PositionProvider>(context).data;

    return Column(
      children: [
        itemHeaderUsers(),
        if (objectList.isEmpty)
          const Center(child: Text("Здесь нет файлов."))
        else
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: objectList.length,
              itemBuilder: (context, idx) {
                var item = objectList[idx];
                return UserItemWidget(
                  item: item,
                  mainPosition: mainPosition,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget itemHeaderUsers() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 12),
        SizedBox(width: 168,
        child: Text("Email")
        ),
        SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Имя")
        ),
        SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Фамилия")
        ),
        SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Отчество")
        ),
        SizedBox(width: 12),
       SizedBox(width: 96,
        child: Text("Заблокирован")
        ),
        SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Удален")
        ),
        SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Размер хранилища")
        ),
    SizedBox(width: 12),
       SizedBox(width: 84,
        child: Text("Дата создания")
        ),
      ],
    );
  }
}
