import 'package:chat_bit/screens/callscreens/pickup/pickup_layout.dart';
import 'package:chat_bit/screens/pageviews/logs/widgets/LogListContainer.dart';
import 'package:chat_bit/utils/universal_variables.dart';
import 'package:chat_bit/widgets/skype_appbar.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: SkypeAppBar(
          title: "Calls",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
      ),
    );
  }
}
