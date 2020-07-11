import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_bit/models/contact.dart';
import 'package:chat_bit/provider/user_provider.dart';
import 'package:chat_bit/resources/chat_methods.dart';
import 'package:chat_bit/screens/callscreens/pickup/pickup_layout.dart';
import 'package:chat_bit/screens/pageviews/chats/widgets/contact_view.dart';
import 'package:chat_bit/screens/pageviews/chats/widgets/quiet_box.dart';
import 'package:chat_bit/screens/pageviews/chats/widgets/user_circle.dart';
import 'package:chat_bit/utils/universal_variables.dart';
import 'package:chat_bit/widgets/appbar.dart';

class ChatListScreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.red,
        ),
        onPressed: () {},
      ),
      title: UserCircle(),
      centerTitle: true,
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
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: customAppBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox(
                  heading: "This is where all the contacts are listed",
                  subtitle:
                      "Search for your friends and family to start calling or chatting with them",
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ));
          }),
    );
  }
}
