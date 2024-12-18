
import 'package:flaxum_fileshare/models/context.dart';
import 'package:flutter/material.dart';
import '../../models/object_.dart';
import '../../models/uxo.dart';

import 'package:provider/provider.dart';

import 'graph_objects.dart';
import 'package:universal_html/html.dart';
import 'package:dio/dio.dart';
import 'package:flaxum_fileshare/dio_client.dart';


class UxoListStateful extends StatefulWidget {
  const UxoListStateful(
      {super.key, required UxoItem uxoItem,})
      : _uxoItem = uxoItem;
  final UxoItem _uxoItem;

  @override
  State<UxoListStateful> createState() => _UxoListStateful();
}

class _UxoListStateful extends State<UxoListStateful> {
  @override
  Widget build(BuildContext context) {
    return Text(widget._uxoItem.owner_user.owner_email);
  }
}
