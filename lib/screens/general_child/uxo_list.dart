import 'package:flutter/material.dart';
import '../../models/uxo.dart';

class UxoListStateful extends StatefulWidget {
  const UxoListStateful({
    super.key,
    required UxoItem uxoItem,
  }) : _uxoItem = uxoItem;
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
