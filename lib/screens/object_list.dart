import 'package:flutter/material.dart';
import '../models/object_.dart';
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';

final dateTimeNow = DateTime.now();

// //mocked
// final objects = [
//   Object_("id", "parent_id", "owner_id", "creator_id", "name", 52, "dir",
//       "mimetype", dateTimeNow, dateTimeNow, false, false),
//   Object_("id", "parent_id", "owner_id", "creator_id", "name", 52, "dir",
//       "mimetype", dateTimeNow, dateTimeNow, false, false),
// ];

// final List<Object_> items = objects;

//left side main
Widget objectListWidget(BuildContext context, List<Object_> object_list) {
  return object_list.isEmpty
      ? Center(child: Text('Empty'))
      : ListView.builder(
        
          itemCount: Provider.of<ObjectProvider>(context).data!.length,
          itemBuilder: (context, idx) {
            var item = Provider.of<ObjectProvider>(context).data[idx];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.id),
                  Text(item.name),
                  Text(item.type),
                  Text(item.size.toString()),
                  Text(item.created_at.toString()),
                ],
              ),
            );
          },
        );
}
