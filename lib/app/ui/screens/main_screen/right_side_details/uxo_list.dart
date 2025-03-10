import 'package:flaxum_fileshare/app/utils/utils_class.dart';
import 'package:flutter/material.dart';

import 'package:flaxum_fileshare/app/models/uxo/uxo.dart';

class UxoListStateful extends StatefulWidget {
  const UxoListStateful({
    super.key,
    required List<UxoItem> uxoItems,
  }) : _uxoItems = uxoItems;
  final List<UxoItem> _uxoItems;

  @override
  State<UxoListStateful> createState() => _UxoListStateful();
}

class _UxoListStateful extends State<UxoListStateful> {
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._uxoItems.length,
      itemBuilder: (context, idx) {
        var item = widget._uxoItems[idx];
        return Column(children: [
          Container(
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
              child: SizedBox(
                width: 500,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.person_add_alt_sharp),
                    Column(
                      children: [
                        const Spacer(flex: 1),
                        Text(item.ownerUser.ownerEmail,
                            style: utils.styleTextUtil.commonTextStyle(),
                            overflow: TextOverflow.ellipsis),
                        const Spacer(flex: 1),
                        Row(
                          children: [
                            Text(
                              "read",
                              style: utils.styleTextUtil.commonTextStyle(),
                            ),
                            Checkbox(
                              isError: true,
                              tristate: true,
                              value: item.uxo.canRead,
                              onChanged: null,
                            ),
                            Text(
                              "edit",
                              style: utils.styleTextUtil.commonTextStyle(),
                            ),
                            Checkbox(
                              isError: true,
                              tristate: true,
                              value: item.uxo.canEdit,
                              onChanged: null,
                            ),
                            Text(
                              "delete",
                              style: utils.styleTextUtil.commonTextStyle(),
                            ),
                            Checkbox(
                              isError: true,
                              tristate: false,
                              value: item.uxo.canDelete,
                              onChanged: null,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
        ]);
      },
    );
  }
}
