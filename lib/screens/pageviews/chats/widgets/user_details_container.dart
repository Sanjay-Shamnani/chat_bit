import 'package:chat_bit/models/user.dart';
import 'package:chat_bit/provider/user_provider.dart';
import 'package:chat_bit/resources/auth_methods.dart';
import 'package:chat_bit/screens/chatscreens/widgets/cached_image.dart';
import 'package:chat_bit/screens/login_screen.dart';
import 'package:chat_bit/screens/pageviews/chats/widgets/shimmering_logo.dart';
import 'package:chat_bit/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut;

      if (isLoggedOut) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            centerTitle: true,
            title: Text('My Profile'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => signOut(),
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ],
          ),
          UserDetailsBody(),
        ],
      ),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
          CachedImage(
            user.profilePhoto,
            isRound: true,
            radius: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.email,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
