import 'package:flaxum_fileshare/models/context.dart';
import 'package:flaxum_fileshare/screens/general_child/format_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/object_.dart';
import '../../models/uxo.dart';
import '../../providers/object_provider.dart';
import '../../providers/context_provider.dart';
import '../../providers/uxo_provider.dart';
import 'graph_objects.dart';
import 'package:universal_html/html.dart';
import 'package:dio/dio.dart';
import 'package:flaxum_fileshare/dio_client.dart';

class ObjectListWidget extends StatefulWidget {
  @override
  _ObjectListWidgetState createState() => _ObjectListWidgetState();
}

class _ObjectListWidgetState extends State<ObjectListWidget> {
  @override
  void initState() {
    super.initState();
    // Prevent default event handler
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    List<Object_> objectList = Provider.of<ObjectProvider>(context).data;
    Context ctx = Provider.of<ContextProvider>(context).data;

    return objectList.isEmpty
        ? const Center(child: Text("Здесь нет файлов."))
        : ListView.builder(
            itemCount: objectList.length,
            itemBuilder: (context, idx) {
              var item = objectList[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () async => _onTap(item),
                  onSecondaryTapDown: (details) =>
                      _onSecondaryTap(details, item, ctx),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        elementIcon(item.type, 25, item),
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 4,
                          child: Text(item.name,
                              style: commonTextStyle(),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 2,
                          child: Text(formatBytes(item.size),
                              style: commonTextStyle(),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 4,
                          child: Text(formatDateTime(item.created_at),
                              style: commonTextStyle(),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  void _onTap(Object_ object) async {
    final response = await dioUnauthorized.get('/access/list/${object.id}',
        options: Options(contentType: "application/json", headers: {
          "authorization": getTokenFromCookie(),
        }));
    if (response.statusCode == 200) {
      final result = GetUxoResponse.fromJson(response.data);
      Provider.of<UxoProvider>(context, listen: false).updateData(result.data);
      Provider.of<ContextProvider>(context, listen: false)
          .updateUxoPointer(object);
    } else if (response.statusCode == 401) {
      Navigator.of(context).pushReplacementNamed('/auth');
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load objects');
    }
  }

  void _onSecondaryTap(TapDownDetails details, Object_ item, Context ctx) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    List<PopupMenuEntry<int>> menuItems = [];

    if (item.type == "File" && ctx.current_scope != Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 1,
          child: const Text('Скачать'),
          onTap: () async {
            var response = await dioUnauthorized.get('/download',
                queryParameters: {'file_id': item.id},
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));

            if (response.statusCode == 200) {
              final url = response.data["data"];
              AnchorElement(href: url)
                ..setAttribute('download', '<downloaded_file_name.pdf>')
                ..click();
            }
          }));
    }

    /// soft deleted
    if (ctx.current_scope == Scope.own) {
      menuItems.add(PopupMenuItem(
          value: 2,
          child: const Text('Поместить в корзину'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": true,
                  "hard_delete": false
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    if (ctx.current_scope == Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 3,
          child: const Text('Удалить полностью'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": true,
                  "hard_delete": true
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    if (ctx.current_scope == Scope.trash) {
      menuItems.add(PopupMenuItem(
          value: 4,
          child: const Text('Восстановить'),
          onTap: () async {
            var response = await dioUnauthorized.delete('/object',
                data: {
                  "file_id": item.id,
                  "delete_mark": false,
                  "hard_delete": false
                },
                options: Options(contentType: "application/json", headers: {
                  "authorization": getTokenFromCookie(),
                }));
            if (response.statusCode == 200) {
              Provider.of<ObjectProvider>(context, listen: false)
                  .remodeItem(item.id);
            }
          }));
    }

    showMenu<int>(
      context: context,
      items: menuItems,
      position: RelativeRect.fromSize(
        details.globalPosition & const Size(48.0, 48.0),
        overlay.size,
      ),
    ).then((value) {
      switch (value) {
        case 1:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Скачать clicked'),
            behavior: SnackBarBehavior.floating,
          ));
          break;
        case 2:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Удалить clicked'),
            behavior: SnackBarBehavior.floating,
          ));
          break;
        default:
      }
    });
  }
}
