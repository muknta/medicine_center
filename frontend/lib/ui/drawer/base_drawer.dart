import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.medical_services_outlined),
            title: Text('Hospitals'),
            onTap: () => Get.toNamed(Routes.Hospitals),
          ),
        ],
      ),
    ));
  }
}

class IconTile extends StatelessWidget {
  final IconButton iconButton;
  final Color backColor;

  IconTile({this.iconButton, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(15)),
          child: iconButton),
    );
  }
}
