import 'package:flaxum_fileshare/app/models/user/user.dart';
import 'package:flutter/material.dart';

Widget aboutUser(UserPublic user) {
  return Row(
    children: [
      Text(user.email),
      const SizedBox(width: 12),
      Text(user.name1),
      const SizedBox(width: 12),
      Text(user.roleType),
      const SizedBox(width: 12),
      Text(user.storageSize.toString()),
      const SizedBox(width: 12),
    ],
  );
}
