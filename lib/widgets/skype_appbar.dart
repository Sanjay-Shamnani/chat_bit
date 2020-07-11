import 'package:chat_bit/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SkypeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final List<Widget> actions;

  const SkypeAppBar({Key key, @required this.title, @required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      actions: actions,
      title: title is String
          ? Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          : title,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications),
        color: Colors.white,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
