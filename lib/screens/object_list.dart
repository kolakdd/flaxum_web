import 'package:flutter/material.dart';
import '../models/object_.dart';
import 'package:provider/provider.dart';
import '../providers/object_provider.dart';
import 'general_child/graph_objects.dart';

/* 
  Левый виджет главного экрана где показывается список
  Всех сущевтвующих файлов  
*/
Widget objectListWidget(BuildContext context, List<Object_> object_list) {
  return object_list.isEmpty
      ? const Center(child: Text("Здесь нет файлов."))
      : ListView.builder(
          itemCount: Provider.of<ObjectProvider>(context).data.length,
          itemBuilder: (context, idx) {
            var item = Provider.of<ObjectProvider>(context).data[idx];
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                        topRight: Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      graphElement(item.type, 25),
                      Text(item.name),
                      Text(item.size.toString()),
                      Text(item.created_at.toString()),
                    ],
                  ),
                ));
          },
        );
}
