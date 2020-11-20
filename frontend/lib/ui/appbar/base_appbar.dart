import 'package:flutter/material.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  BaseAppBar({Key key, this.title = ''})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _BaseAppBarState createState() => _BaseAppBarState(title);
}

class _BaseAppBarState extends State<BaseAppBar> {
  final String title;

  _BaseAppBarState(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey));
  }
}
